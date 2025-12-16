# FINAL PYTHON LSP DIAGNOSTIC - CURRENT STATE

## SUCCESS ✅
- **Only ONE pylsp client is ACTIVE** (id: 4) - pipx binary with correct settings
- **ruff is working** (id: 3)
- **null-ls is working** (id: 5)
- **No pyright active clients**
- **No mason pylsp active clients**

## REMAINING ISSUE ⚠️
**mason-lspconfig is STILL registering configurations** for pylsp and pyright in the "Enabled Configurations" section, even though they're not active clients. This might cause them to auto-attach later.

## CURRENT ACTIVE CLIENTS (from :LspInfo)

### ✅ Working Correctly:
1. **ruff (id: 3)** - LSP server for linting/formatting
2. **pylsp (id: 4)** - pipx binary `/Users/jn/.local/bin/pylsp` with correct settings
   - All linting plugins disabled ✅
   - Only jedi completion enabled ✅
   - Settings applied correctly ✅
3. **null-ls (id: 5)** - Bridge for ruff formatting

### ❌ Still Registered (but not active):
- **pylsp** - mason's version (cmd: `{ "pylsp" }`, no settings)
- **pyright** - (cmd: `{ "pyright-langserver", "--stdio" }`, filetypes: python)

## ROOT CAUSE

The handler in `mason-lspconfig` prevents `setup()` from being called, but the configuration is still being **registered** in lspconfig's internal registry. This means:

1. The config exists in "Enabled Configurations"
2. It might auto-attach if conditions change
3. The handler approach doesn't prevent registration, only setup

## WHAT NEEDS TO BE FIXED

### Option 1: Prevent Registration Entirely
Override mason-lspconfig's default handler system to skip pylsp/pyright before they're registered.

### Option 2: Use `autostart = false`
Set `autostart = false` in the lspconfig setup to prevent auto-attachment, but this might not work with mason-lspconfig.

### Option 3: Override mason-lspconfig's setup function
Intercept mason-lspconfig before it processes pylsp/pyright.

## CURRENT CONFIGURATION FILES

### `/Users/jn/.config/nvim/lua/plugins/init.lua`
```lua
opts.handlers = opts.handlers or {}
opts.handlers.pyright = function() end -- Do nothing
opts.handlers.pylsp = function() end -- Do nothing
opts.handlers.default = function(server_name)
  if server_name ~= "pylsp" and server_name ~= "pyright" then
    lspconfig[server_name].setup({})
  end
end
```

**Status**: Handler prevents setup but configs still registered

### `/Users/jn/.config/nvim/lua/configs/lspconfig.lua`
```lua
-- Autocmd kills wrong clients after attach
vim.api.nvim_create_autocmd("LspAttach", {
  callback = function(args)
    local client = vim.lsp.get_client_by_id(args.data.client_id)
    if client then
      if client.name == "pyright" then
        vim.lsp.stop_client(client.id, true)
      elseif client.name == "pylsp" and cmd ~= pipx_path then
        vim.lsp.stop_client(client.id, true)
      end
    end
  end,
})

-- Manual pylsp setup with pipx binary
lspconfig.pylsp.setup({
  cmd = { vim.fn.expand("~/.local/bin/pylsp") },
  settings = { ... correct settings ... },
})
```

**Status**: ✅ Working - only correct pylsp is active

## THE REAL PROBLEM

mason-lspconfig has a `before_init` hook for pylsp that runs BEFORE our handler. This means:

1. mason-lspconfig processes pylsp
2. Registers it in lspconfig's config registry
3. Our handler prevents setup, but registration already happened
4. Config shows up in "Enabled Configurations"

## SOLUTION NEEDED

Prevent mason-lspconfig from processing pylsp/pyright at all, not just preventing setup.

### Research Needed:
1. How does mason-lspconfig register configurations?
2. Can we prevent registration before it happens?
3. Is there a way to remove configurations from lspconfig's registry?
4. Can we override mason-lspconfig's server processing order?

## WORKAROUND (Current State)

The autocmd kills wrong clients immediately, so they never become active. But they're still registered, which is confusing and might cause issues.

## NEXT STEPS FOR RESEARCH

1. **Investigate mason-lspconfig internals** - How does it register configs?
2. **Check lspconfig API** - Can we unregister configurations?
3. **Override mason-lspconfig setup** - Intercept before registration
4. **Check if "Enabled Configurations" matters** - Maybe it's harmless if clients aren't active?

## VERIFICATION

Run `:LspInfo` and check:
- ✅ Only ONE pylsp in "Active Clients" (id: 4, pipx path)
- ✅ No pyright in "Active Clients"
- ⚠️ pylsp and pyright still in "Enabled Configurations" (but not active)

## IF PYFLAKES STILL APPEARS

If you're still seeing pyflakes diagnostics despite only one pylsp being active:

1. Check diagnostic source: `:lua vim.dump(vim.diagnostic.get(0))` - look for `source` field
2. Verify handler is working: Check if diagnostics handler is filtering pylsp
3. Check ruff diagnostics: Make sure ruff isn't showing pyflakes-style errors
4. Verify pylsp settings: Check `:LspInfo` shows plugins disabled correctly

## FILES TO CHECK

1. `/Users/jn/.config/nvim/lua/plugins/init.lua` - mason-lspconfig handler
2. `/Users/jn/.config/nvim/lua/configs/lspconfig.lua` - pylsp setup and autocmd
3. Check if there's a `pyproject.toml` or `.pylsp` config overriding settings
