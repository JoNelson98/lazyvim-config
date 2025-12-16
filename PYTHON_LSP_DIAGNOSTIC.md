# Python LSP Configuration Diagnostic Report

## USER'S GOAL
Set up Python LSP with:
- **pylsp** for code completions, hover, references, symbols (completion features only)
- **ruff** (via null-ls) for ALL linting and formatting
- **NO** pyright
- **NO** pylsp linting/formatting plugins (pyflakes, pycodestyle, autopep8, yapf, mccabe, pylsp_mypy, pylsp_black, pylsp_isort)

## CURRENT SETUP

### File Structure
```
/Users/jn/.config/nvim/
├── lua/
│   ├── configs/
│   │   └── lspconfig.lua          # LSP server configurations
│   └── plugins/
│       ├── init.lua                # Mason/mason-lspconfig setup
│       └── none_ls.lua             # Ruff configuration via null-ls
```

### Current Configuration Files

#### 1. `/Users/jn/.config/nvim/lua/plugins/none_ls.lua`
**Purpose**: Configures ruff for formatting and linting via null-ls

**Current setup**:
- Uses `nvimtools/none-ls.nvim` plugin
- Ruff installed via `mason-null-ls`
- Sources configured:
  - `none-ls.formatting.ruff` with `--fix` flag
  - `none-ls.formatting.ruff_format`
- Auto-formats on `BufWritePre` via autocmd

**Status**: ✅ This is working correctly - ruff handles formatting/linting

#### 2. `/Users/jn/.config/nvim/lua/configs/lspconfig.lua`
**Purpose**: Configures LSP servers (pylsp, gopls, ts_ls, etc.)

**Current pylsp configuration** (lines 68-110):
```lua
pcall(function()
  local lspconfig = require("lspconfig")
  lspconfig.pylsp.setup({
    cmd = { "pylsp" },
    filetypes = { "python" },
    root_dir = util.root_pattern(...),
    settings = {
      pylsp = {
        plugins = {
          -- Disabled plugins:
          autopep8 = { enabled = false },
          yapf = { enabled = false },
          pylsp_black = { enabled = false },
          pycodestyle = { enabled = false },
          pyflakes = { enabled = false },
          pylint = { enabled = false },
          mccabe = { enabled = false },
          pylsp_mypy = { enabled = false },
          pylsp_isort = { enabled = false },
          rope_autoimport = { enabled = false },
          -- Enabled plugins:
          jedi_completion = { enabled = true, fuzzy = true },
          jedi_hover = { enabled = true },
          jedi_references = { enabled = true },
          jedi_signature_help = { enabled = true },
          jedi_symbols = { enabled = true },
          rope_completion = { enabled = true },
        },
      },
    },
  })
end)
```

**Status**: ⚠️ Configuration looks correct BUT pylsp is still sending linting diagnostics (pyflakes, etc.)

#### 3. `/Users/jn/.config/nvim/lua/plugins/init.lua`
**Purpose**: Mason package management

**Current setup**:
- Mason ensures `python-lsp-server` or `pylsp` is installed
- Filters out `pyright` and `pyright-langserver`
- mason-lspconfig handler for pyright does nothing (prevents auto-start)

**Status**: ✅ Correctly prevents pyright installation/startup

## PROBLEM

**Issue**: Despite disabling all linting plugins in pylsp settings, pylsp is STILL sending linting diagnostics (pyflakes, pycodestyle, etc.) that conflict with ruff.

**Symptoms**:
- User sees pyflakes linting errors
- pylsp diagnostics are showing up alongside ruff diagnostics
- Formatting may be conflicting

## WHAT WAS ATTEMPTED (AND FAILED)

1. **Disabled plugins in settings** - Set `enabled = false` for all linting/formatting plugins
   - Result: ❌ pylsp still sends diagnostics

2. **Tried disabling diagnostic capabilities** - Set `client.server_capabilities.diagnosticProvider = false`
   - Result: ❌ Didn't work, removed in final version

3. **Tried overriding diagnostic handler** - Filter out pylsp diagnostics globally
   - Result: ❌ Too complex, removed

4. **Tried disabling formatting capabilities** - Multiple attempts
   - Result: ❌ Formatting still conflicted

## ROOT CAUSE ANALYSIS

The issue is that **pylsp settings may not be properly applied**, OR pylsp has default plugins that override the settings, OR the settings format is incorrect.

Possible issues:
1. pylsp may ignore `enabled = false` if plugins are installed/enabled by default
2. Settings may need to be sent via LSP `workspace/didChangeConfiguration` notification
3. pylsp may have a configuration file (pyproject.toml, setup.cfg, etc.) that overrides these settings
4. The settings structure may be incorrect for the pylsp version being used

## WHAT NEEDS TO BE RESEARCHED

1. **How to properly disable pylsp plugins** - Check pylsp documentation for correct settings format
2. **How to prevent pylsp from sending diagnostics** - May need to disable diagnostics at the LSP capability level, not just plugin level
3. **pylsp configuration precedence** - Check if there are config files that override LSP settings
4. **Alternative approaches**:
   - Use pylsp's `configuration` method to send settings after initialization
   - Check if there's a way to disable diagnostics provider capability correctly
   - Verify if pylsp respects `enabled = false` or needs a different approach

## ENVIRONMENT DETAILS

- **Neovim setup**: NvChad starter on LazyVim
- **pylsp installation**: Via pipx (`pipx install python-lsp-server`)
- **pylsp location**: `/Users/jn/.local/bin/pylsp`
- **ruff**: Installed via mason-null-ls, configured in none_ls.lua
- **Python project**: Odoo project (has `__manifest__.py`, `__openerp__.py` root markers)

## FILES TO CHECK

1. Check if there's a `pyproject.toml` or `.pylsp` config file in the project that might override settings
2. Check pylsp logs: `:LspLog` in Neovim
3. Check what pylsp actually receives: May need to inspect LSP communication

## NEXT STEPS FOR RESEARCH

1. Research pylsp documentation for correct plugin disabling method
2. Check if pylsp has a way to disable diagnostics entirely (not just plugins)
3. Verify the settings structure matches pylsp's expected format
4. Consider if pylsp needs to be configured via `workspace/didChangeConfiguration` instead of initial settings
5. Check pylsp GitHub issues for similar problems
