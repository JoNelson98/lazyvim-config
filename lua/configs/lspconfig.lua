require("nvchad.configs.lspconfig").defaults()

-- read :h vim.lsp.config for changing options of lsp servers 
require('lspconfig').gopls.setup{
  cmd = {'gopls'},
  filetypes = {'go','gomod'},
  root_dir = require('lspconfig').util.root_pattern('go.mod','.git'),
  settings = {
    gopls = {
      analyses = {
        unusedparams = true,
        shadow = true,
        unreachable = true,
      },
      staticcheck = true,
    }
  }
}

-- TypeScript/JavaScript (tsserver via typescript-tools or built-in)
-- Use the new name `ts_ls` with mason-lspconfig
pcall(function()
  require('lspconfig').ts_ls.setup{}
end)

-- ESLint
pcall(function()
  require('lspconfig').eslint.setup{
    settings = {
      workingDirectories = { mode = "auto" },
      format = false,
    },
  }
end)

-- HTML/CSS/JSON
pcall(function() require('lspconfig').html.setup{} end)
pcall(function() require('lspconfig').cssls.setup{} end)
pcall(function() require('lspconfig').jsonls.setup{} end)
