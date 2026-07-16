vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
  pattern = "*.py",
  command = "set filetype=python",
})

local python_highlights = require "configs.python_highlights"

python_highlights.apply()
vim.api.nvim_create_autocmd("ColorScheme", {
  callback = python_highlights.apply,
})
vim.api.nvim_create_autocmd("FileType", {
  pattern = "python",
  callback = python_highlights.apply,
})

vim.lsp.buf.format({
  filter = function(client)
    return client.name == "pylsp"
  end,
})
