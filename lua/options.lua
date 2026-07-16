require "nvchad.options"

-- add yours here!
vim.opt.shortmess:append("I")
vim.g.nvim_dashboard_disable = true
vim.opt.termguicolors = true
vim.opt.winblend = 10
vim.opt.pumblend = 10
-- Make visual < / > snap to shiftwidth boundaries.
vim.opt.shiftround = true

-- Fix swap file directory
vim.opt.directory = vim.fn.stdpath("state") .. "/swap//"
-- Create swap directory if it doesn't exist
vim.fn.mkdir(vim.fn.stdpath("state") .. "/swap", "p")

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

-- NOTE: suppress warning/info diagnostics and notifications; keep errors.
vim.diagnostic.config({
  virtual_text = { severity = { min = vim.diagnostic.severity.ERROR } },
  signs = { severity = { min = vim.diagnostic.severity.ERROR } },
  underline = { severity = { min = vim.diagnostic.severity.ERROR } },
  float = { severity = { min = vim.diagnostic.severity.ERROR } },
})

local original_notify = vim.notify
vim.notify = function(msg, level, opts)
  if not level or level < vim.log.levels.ERROR then
    return
  end
  return original_notify(msg, level, opts)
end

-- Load autocmds
pcall(require, "configs.autocmds")
