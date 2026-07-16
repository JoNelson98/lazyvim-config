-- Containerized version of the legacy NvChad base46 theme "custom_dragon".
-- This lets you keep the theme isolated and reusable even if you switch away
-- from it as your active colorscheme.

-- Start from the upstream kanagawa-dragon theme and tweak as desired
local M = require "base46.themes.kanagawa-dragon"

-- High-contrast: force pitch-black backgrounds and darker UI surfaces
M.base_16.base00 = "#101010" -- editor background

M.base_30.black = "#000000"
M.base_30.darker_black = "#000000"
M.base_30.black2 = "#060606"
M.base_30.one_bg = "#0a0a0a"
M.base_30.one_bg2 = "#101010"
M.base_30.one_bg3 = "#141414"
M.base_30.line = "#0f0f0f" -- cursorline
M.base_30.statusline_bg = "#0a0a0a"
M.base_30.lightbg = "#111111" -- floats/pmenus

-- Ensure common UI groups use true black
M.polish_hl = vim.tbl_deep_extend("force", M.polish_hl or {}, {
  Normal = { bg = "#000000" },
  NormalNC = { bg = "#000000" },
  NormalFloat = { bg = "#101010" },
  FloatBorder = { bg = "#101010" },
  SignColumn = { bg = "#000000" },
  EndOfBuffer = { fg = "#000000" }, -- hide tildes
  NonText = { fg = "#fff0f0" },

  -- Indent-blankline (ibl) groups + cursor tint
  IblIndent = { fg = "#606060", blend = 0 },
  IblScope = { fg = "#808080", bold = true, blend = 0 },
  Cursor = { fg = "#101010", bg = "#f9bb80" },

  -- Restore NvimTree background to upstream kanagawa-dragon shades
  nvimtree = {
    NvimTreeNormal = { bg = "#100e0e" },
    NvimTreeNormalNC = { bg = "#100e0e" },
    NvimTreeEndOfBuffer = { fg = "#100e0e" },
    NvimTreeWinSeparator = { fg = "#100e0e", bg = "#100e0e" },
    NvimTreeCursorLine = { bg = "#181616" },
  },

  -- Telescope background colors
  TelescopePromptNormal = { bg = M.base_16.base00, fg = "NONE" },
  TelescopeResultsNormal = { bg = M.base_16.base00, fg = "NONE" },
  TelescopePreviewNormal = { bg = M.base_16.base00, fg = "NONE" },
  TelescopeBorder = { bg = M.base_16.base00, fg = M.base_16.base00 },
  TelescopePromptBorder = { bg = M.base_16.base00, fg = M.base_16.base00 },
  TelescopeResultsBorder = { bg = M.base_16.base00, fg = M.base_16.base00 },
  TelescopePreviewBorder = { bg = M.base_16.base00, fg = M.base_16.base00 },
})

M.type = "dark"

return M
