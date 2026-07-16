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

local function apply_wezterm_match_highlights()
  local transparent_groups = {
    "Normal",
    "NormalNC",
    "SignColumn",
    "EndOfBuffer",
    "LineNr",
    "FoldColumn",
    "CursorLineNr",
    "WinSeparator",
    "StatusLine",
    "StatusLineNC",
    "TabLineFill",
  }

  for _, group in ipairs(transparent_groups) do
    vim.api.nvim_set_hl(0, group, { bg = "NONE" })
  end

  -- Keep floating UI readable while matching WezTerm's navy base.
  vim.api.nvim_set_hl(0, "NormalFloat", { bg = "#172234" })
  vim.api.nvim_set_hl(0, "FloatBorder", { bg = "#172234", fg = "#5E7393" })
  vim.api.nvim_set_hl(0, "Pmenu", { bg = "#172234" })

  -- Keep nvim-tree sidebar on the same navy surface.
  vim.api.nvim_set_hl(0, "NvimTreeNormal", { bg = "#172234" })
  vim.api.nvim_set_hl(0, "NvimTreeNormalNC", { bg = "#172234" })
  vim.api.nvim_set_hl(0, "NvimTreeEndOfBuffer", { bg = "#172234", fg = "#172234" })
  vim.api.nvim_set_hl(0, "NvimTreeWinSeparator", { bg = "#172234", fg = "#5E7393" })
  vim.api.nvim_set_hl(0, "NvimTreeCursorLine", { bg = "#1E2B41" })

  -- Command line area should remain transparent (avoid dark strip on ':' and ';').
  vim.api.nvim_set_hl(0, "MsgArea", { bg = "NONE" })
  vim.api.nvim_set_hl(0, "Cmdline", { bg = "NONE" })
  vim.api.nvim_set_hl(0, "CmdlinePrompt", { bg = "NONE" })
  vim.api.nvim_set_hl(0, "NoiceCmdline", { bg = "NONE" })
  vim.api.nvim_set_hl(0, "NoiceCmdlinePopup", { bg = "NONE" })
  vim.api.nvim_set_hl(0, "NoiceCmdlinePopupBorder", { bg = "NONE", fg = "#5E7393" })
  vim.api.nvim_set_hl(0, "NoiceCmdlinePopupTitle", { bg = "NONE", fg = "#B2CAED" })
  vim.api.nvim_set_hl(0, "NoiceCmdlineIcon", { bg = "NONE", fg = "#B2CAED" })

  -- Ensure ibl highlight groups exist before indent-blankline loads.
  vim.api.nvim_set_hl(0, "IblIndent", { fg = "#606A70", nocombine = true })
  vim.api.nvim_set_hl(0, "IblScope", { fg = "#8A979E", bold = true, nocombine = true })
end

local glass_group = vim.api.nvim_create_augroup("WeztermGlassMatch", { clear = true })
vim.api.nvim_create_autocmd("ColorScheme", {
  group = glass_group,
  callback = apply_wezterm_match_highlights,
})

apply_wezterm_match_highlights()
vim.schedule(apply_wezterm_match_highlights)

-- Keep NvimTree sidebar visually unchanged when it loses focus.
-- Fires right as the cursor leaves NvimTree (after all plugin setup), so
-- NvimTree can't override it afterward.
vim.api.nvim_create_autocmd("WinLeave", {
  callback = function()
    if vim.bo.filetype ~= "NvimTree" then return end
    local win = vim.api.nvim_get_current_win()
    local hl = vim.wo[win].winhighlight
    hl = hl:gsub("NormalNC:NvimTreeNormalNC", "NormalNC:NvimTreeNormal")
    if not hl:find("NormalNC:") then
      hl = hl .. (hl ~= "" and "," or "") .. "NormalNC:NvimTreeNormal"
    end
    vim.wo[win].winhighlight = hl
  end,
})

-- Load autocmds
pcall(require, "configs.autocmds")
