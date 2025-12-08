require("nvchad.configs.lspconfig").defaults()

-- LSP servers configuration

-- New  Neovim 0.11 LSP entry point
local lsp = vim.lsp.config
local util = require "lspconfig.util"

lsp.gopls.setup {
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
}

-- TypeScript/JavaScript (tsserver via typescript-tools or built-in)
-- Use the new name `ts_ls` with mason-lspconfig
pcall(function()
  lsp.ts_ls.setup {}
end)

-- ESLint
pcall(function()
  lsp.eslint.setup {
    settings = {
      workingDirectories = { mode = "auto" },
      format = false,
    },
  }
end)

-- HTML/CSS/JSON
pcall(function()
  lsp.html.setup {}
end)
pcall(function()
  lsp.cssls.setup {}
end)
pcall(function()
  lsp.jsonls.setup {}
end)
