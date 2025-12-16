# COMPLETE NEOVIM PYTHON LSP DIAGNOSTIC

## USER'S GOAL
- **pylsp** for code completions ONLY (no linting, no formatting)
- **ruff** (via null-ls) for ALL linting and formatting
- **NO** pyright
- **NO** pylsp linting plugins (pyflakes, pycodestyle, autopep8, yapf, mccabe, pylsp_mypy, pylsp_black, pylsp_isort)

## CURRENT PROBLEM
**pyflakes and other pylsp linting plugins are STILL running despite being disabled in config**

## FILE STRUCTURE
```
/Users/jn/.config/nvim/
├── lua/
│   ├── configs/
│   │   └── lspconfig.lua          # LSP server configurations
│   └── plugins/
│       ├── init.lua                # Mason/mason-lspconfig setup + all plugins
│       ├── none_ls.lua             # Ruff configuration via null-ls
│       ├── cmp_cmdline.lua
│       ├── gitsigns.lua
│       ├── snacks.lua
│       ├── spelunker.lua
│       ├── tmux_panes.lua
│       └── toggleterm.lua
├── lazy-lock.json                  # All installed plugins
└── init.lua                        # Entry point
```

## INSTALLED PLUGINS (from lazy-lock.json)

### Core Framework
- **NvChad** (v2.5) - Base framework
- **lazy.nvim** - Plugin manager
- **base46** (v3.0) - Colorscheme system
- **ui** (v3.0) - UI components

### LSP & Completion
- **nvim-lspconfig** - LSP client
- **mason.nvim** - LSP/DAP/linter installer
- **mason-lspconfig.nvim** - Bridge between mason and lspconfig
- **mason-null-ls.nvim** - Mason integration for null-ls
- **nvim-cmp** - Completion engine
- **cmp-nvim-lsp** - LSP completion source
- **cmp-buffer** - Buffer completion source
- **cmp-cmdline** - Command line completion
- **cmp-async-path** - Path completion
- **cmp-nvim-lua** - Lua completion
- **cmp_luasnip** - Snippet completion
- **LuaSnip** - Snippet engine
- **friendly-snippets** - Snippet collection

### Linting & Formatting
- **none-ls.nvim** - Bridge for formatters/linters (ruff configured here)
- **none-ls-extras.nvim** - Extra sources for none-ls
- **conform.nvim** - Formatter (configured for lua, js, ts, tsx)

### Treesitter
- **nvim-treesitter** - Syntax parsing
- **nvim-ts-autotag** - Auto-close HTML tags

### UI & Navigation
- **alpha-nvim** - Dashboard
- **nvim-tree.lua** - File tree
- **telescope.nvim** - Fuzzy finder
- **flash.nvim** - Jump navigation
- **which-key.nvim** - Keybinding helper
- **noice.nvim** - UI improvements
- **nvim-notify** - Notifications
- **nvim-web-devicons** - Icons

### Git
- **gitsigns.nvim** - Git signs
- **lazygit.nvim** - LazyGit integration

### Other
- **go.nvim** - Go development
- **vim-go** - Go plugin
- **leetcode.nvim** - LeetCode integration
- **spelunker.vim** - Spell checker
- **nvim-autopairs** - Auto-pair brackets
- **indent-blankline.nvim** - Indent guides
- **toggleterm.nvim** - Terminal
- **tmux.nvim** - Tmux integration
- **vim-tmux-navigator** - Tmux navigation
- **snacks.nvim** - File picker
- **popup-menu.nvim** - Popup menus
- **menu** - Menu system
- **minty** - Theme
- **volt** - Theme
- **midnight.nvim** - Theme
- **vim-be-good** - Typing game

## CURRENT CONFIGURATION

### 1. `/Users/jn/.config/nvim/lua/configs/lspconfig.lua`

**Current pylsp config (lines 68-124):**
```lua
pcall(function()
  local lspconfig = require("lspconfig")
  local cmp_nvim_lsp = require("cmp_nvim_lsp")
  
  lspconfig.pylsp.setup({
    cmd = { "pylsp" },
    filetypes = { "python" },
    root_dir = util.root_pattern(...),
    capabilities = cmp_nvim_lsp.default_capabilities(),
    settings = {
      pylsp = {
        configurationSources = {}, -- Prevent fallback configs
        plugins = {
          -- ALL DISABLED:
          pyflakes = { enabled = false },
          pycodestyle = { enabled = false },
          pylint = { enabled = false },
          mccabe = { enabled = false },
          autopep8 = { enabled = false },
          yapf = { enabled = false },
          pylsp_black = { enabled = false },
          pylsp_isort = { enabled = false },
          pylsp_mypy = { enabled = false },
          rope_autoimport = { enabled = false },
          rope_completion = { enabled = false },
          -- ONLY ENABLED:
          jedi_completion = { enabled = true, fuzzy = true, include_params = true },
          jedi_hover = { enabled = true },
          jedi_references = { enabled = true },
          jedi_signature_help = { enabled = true },
          jedi_symbols = { enabled = true },
        },
      },
    },
    handlers = {
      ["textDocument/publishDiagnostics"] = function() end, -- Drop all diagnostics
    },
  })
end)
```

**Status**: ⚠️ Config looks correct BUT pyflakes still running

### 2. `/Users/jn/.config/nvim/lua/plugins/none_ls.lua`

**Ruff configuration:**
```lua
null_ls.setup {
  sources = {
    require("none-ls.formatting.ruff").with { extra_args = { "--fix" } },
    require("none-ls.formatting.ruff_format"),
    -- ... other formatters
  },
  on_attach = function(client, bufnr)
    if client.supports_method("textDocument/formatting") then
      vim.api.nvim_create_autocmd("BufWritePre", {
        callback = function()
          vim.lsp.buf.format { async = false }
        end,
      })
    end
  end,
}
```

**Status**: ✅ Ruff configured correctly

### 3. `/Users/jn/.config/nvim/lua/plugins/init.lua`

**Mason configuration:**
- Ensures `python-lsp-server` or `pylsp` installed
- Filters out `pyright`
- Handler for pyright does nothing
- Handler for pylsp registered but empty

**Status**: ✅ Mason config looks correct

### 4. `/Users/jn/.config/nvim/lua/configs/conform.lua`

**Conform formatter config:**
```lua
formatters_by_ft = {
  lua = { "stylua" },
  javascript = { "prettierd" },
  typescript = { "prettierd" },
  -- NO python formatter (ruff handles it)
}
```

**Status**: ✅ No conflict with Python

## POTENTIAL CONFLICTS

### Conflict 1: Handler Override Not Working
The `handlers["textDocument/publishDiagnostics"] = function() end` should drop all pylsp diagnostics, but pyflakes errors are still showing.

**Possible causes:**
1. Handler is being overridden by NvChad defaults
2. Handler is set AFTER pylsp attaches
3. Diagnostics are coming from a different source

### Conflict 2: NvChad Defaults
Line 2 of lspconfig.lua: `require("nvchad.configs.lspconfig").defaults()`

This might be setting up default handlers that override our custom handler.

### Conflict 3: Multiple LSP Clients
Both `none-ls` (ruff) and `pylsp` are attached to Python files. The diagnostics handler might not be filtering correctly.

### Conflict 4: pylsp Settings Not Applied
Even though plugins are set to `enabled = false`, pylsp might:
1. Ignore the settings
2. Have plugins enabled by default config file
3. Not be receiving the settings properly

## SWAP FILE ISSUES

**Swap directory**: `~/.local/state/nvim/swap/`

**Current status**: Swap files were cleared but errors persist

**Possible causes:**
1. Neovim crashed and left swap files
2. Multiple Neovim instances running
3. File permissions issue
4. Swap files from other projects interfering

## WHAT TO CHECK

### 1. Verify pylsp is actually using the config
Run in Neovim:
```
:LspInfo
```
Check if pylsp shows the correct settings.

### 2. Check pylsp logs
```
:LspLog
```
Look for what settings pylsp actually received.

### 3. Check if pyflakes is installed
```bash
pipx runpip python-lsp-server list | grep pyflakes
```

### 4. Check for pylsp config files
Look for:
- `pyproject.toml` in project root
- `.pylsp` config file
- `setup.cfg` with pylsp settings

### 5. Check NvChad defaults
The `nvchad.configs.lspconfig.defaults()` might be setting up handlers that override ours.

## RECOMMENDED FIXES

### Fix 1: Override handler AFTER NvChad loads
Move the handler override to run after NvChad defaults, or use an autocmd.

### Fix 2: Uninstall pyflakes from pylsp environment
```bash
pipx runpip python-lsp-server uninstall pyflakes pycodestyle pylint mccabe
```

### Fix 3: Use workspace/didChangeConfiguration
Send settings via LSP notification instead of initial config.

### Fix 4: Check for project-level config files
pylsp might be reading `pyproject.toml` or other config files that override our settings.

### Fix 5: Disable diagnostics at capability level
Try setting `diagnosticProvider = false` in capabilities (though this might not work).

## NEXT STEPS FOR RESEARCH

1. **Research pylsp configuration precedence** - What overrides what?
2. **Check NvChad's default LSP handler** - Does it override custom handlers?
3. **Verify handler execution order** - When does our handler run vs NvChad's?
4. **Check pylsp documentation** - Is there a way to completely disable diagnostics?
5. **Investigate workspace config files** - Are there config files overriding settings?
6. **Check if pyflakes is actually installed** - Even though it's disabled, is it still loaded?

## SWAP FILE FIX

To permanently fix swap errors:
1. Set `set directory=~/.local/state/nvim/swap//` in options.lua
2. Ensure swap directory exists and is writable
3. Check for multiple Neovim instances running
4. Clear swap files on startup if needed
