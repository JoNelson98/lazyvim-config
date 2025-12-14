require "nvchad.options"

-- add yours here!
vim.opt.shortmess:append("I")
vim.g.nvim_dashboard_disable = true

-- local o = vim.o
-- o.cursorlineopt ='both' -- to enable cursorline!

-- Filetype detection for Go HTML templates (.tmpl)
vim.filetype.add({
  extension = { tmpl = "gotmpl" },
  pattern = {
    [".*%.page%.tmpl"] = "gotmpl",
    [".*%.layout%.tmpl"] = "gotmpl",
  },
})

-- Use Go template-style comments inside templates
vim.api.nvim_create_autocmd("FileType", {
  pattern = { "gotmpl", "gohtmltmpl", "gotexttmpl" },
  callback = function()
    vim.bo.commentstring = "{{/* %s */}}"
  end,
})
