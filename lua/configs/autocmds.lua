vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
  pattern = "*.py",
  command = "set filetype=python",
})

vim.lsp.buf.format({
  filter = function(client)
    return client.name == "pylsp"
  end,
})
