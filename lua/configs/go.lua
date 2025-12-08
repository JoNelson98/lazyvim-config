return function()
  local opts = {
    goimports = "goimports",
    lsp_cfg = true,
  }
  require("go").setup(opts)
  vim.api.nvim_create_autocmd("BufWritePre", {
    pattern = "*.go",
    callback = function()
      require("go.format").goimports()
    end,
    group = vim.api.nvim_create_augroup("GoFormat", {}),
  })
end
