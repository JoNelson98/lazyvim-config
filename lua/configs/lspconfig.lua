-- NvChad default LSP settings
require("nvchad.configs.lspconfig").defaults()

local util = require "lspconfig.util"

-- -----------------------
-- Go (gopls)
-- -----------------------
vim.lsp.config("gopls", {
  cmd = { "gopls" },
  filetypes = { "go", "gomod" },
  root_dir = util.root_pattern("go.mod", ".git"),
  settings = {
    gopls = {
      analyses = {
        unusedparams = true,
        shadow = true,
        unreachable = true,
      },
      staticcheck = true,
    },
  },
})

vim.lsp.enable "gopls"

-- -----------------------
-- TypeScript / JavaScript
-- -----------------------
pcall(function()
  vim.lsp.config("ts_ls", {})
  vim.lsp.enable "ts_ls"
end)

-- -----------------------
-- ESLint
-- -----------------------
pcall(function()
  vim.lsp.config("eslint", {
    settings = {
      workingDirectories = { mode = "auto" },
      format = false,
    },
  })
  vim.lsp.enable "eslint"
end)

-- -----------------------
-- HTML / CSS / JSON
-- -----------------------
for _, server in ipairs { "html", "cssls", "jsonls" } do
  pcall(function()
    vim.lsp.config(server, {})
    vim.lsp.enable(server)
  end)
end

-- -----------------------
-- Python (pyright) - Odoo optimized
-- -----------------------
pcall(function()
  vim.lsp.config("pyright", {
    filetypes = { "python" },
    -- Odoo-specific root markers
    root_dir = util.root_pattern(
      "__manifest__.py",
      "__openerp__.py",
      "odoo.conf",
      "openerp-server.conf",
      "pyproject.toml",
      "setup.py",
      "setup.cfg",
      "requirements.txt",
      ".git"
    ),
    settings = {
      python = {
        analysis = {
          autoImportCompletions = true,
          typeCheckingMode = "basic",
          -- Odoo uses dynamic attributes, so be more lenient
          diagnosticMode = "openFilesOnly",
          useLibraryCodeForTypes = true,
          -- Auto-detect venv
          venvPath = ".",
          venv = ".venv",
        },
        -- Auto-detect Python version
        defaultPythonVersion = "3.8",
      },
    },
  })
  vim.lsp.enable "pyright"
end)
