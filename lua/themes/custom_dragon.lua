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

  -- Defaults integration overrides
  defaults = {
    Comment = { fg = "#c87e88" },
    LineNr = { fg = "#78adba" },
    CursorLineNr = { fg = "#c87e88" },
    LineNrAbove = { fg = "#78adba" },
    LineNrBelow = { fg = "#78adba" },
  },

  -- Treesitter groups (language-agnostic)
  treesitter = {
    ["@comment"] = { fg = "#c87e88" },
    ["@comment.documentation"] = { fg = "#c87e88" },
    -- Make all function-like things #abd8c5
    ["@function"] = { fg = "#abd8c5" },
    ["@function.call"] = { fg = "#abd8c5" },
    ["@function.builtin"] = { fg = "#abd8c5" },
    ["@function.method"] = { fg = "#abd8c5" },
    ["@function.method.call"] = { fg = "#abd8c5" },
    ["@method"] = { fg = "#abd8c5" },
    ["@method.call"] = { fg = "#abd8c5" },
    ["@constructor"] = { fg = "#abd8c5" },

    -- Your requested accents across all languages (#78adba)
    ["@keyword"] = { fg = "#78adba" }, -- const, let, import, async/await, etc.
    ["@keyword.storage"] = { fg = "#78adba" }, -- storage-class variants
    ["@keyword.modifier"] = { fg = "#78adba" }, -- modifiers
    ["@keyword.coroutine"] = { fg = "#78adba" },
    ["@keyword.operator"] = { fg = "#78adba" },
    ["@keyword.function"] = { fg = "#78adba" },
    ["@keyword.return"] = { fg = "#78adba" },
    ["@keyword.conditional"] = { fg = "#78adba" },
    ["@keyword.repeat"] = { fg = "#78adba" },
    ["@keyword.directive.define"] = { fg = "#78adba" },
    ["@keyword.directive"] = { fg = "#78adba" },
    ["@keyword.import"] = { fg = "#78adba" },
    ["@operator"] = { fg = "#78adba" }, -- => and other operators
    ["@punctuation.bracket"] = { fg = "#78adba" }, -- { } ( ) [ ]
    ["@punctuation.delimiter"] = { fg = "#78adba" }, -- , ; : .
    ["@type"] = { fg = "#78adba" },
    ["@type.builtin"] = { fg = "#cacaca" },
    -- Strings (all variants)
    ["@string"] = { fg = "#f8f8f6" },
    ["@string.regex"] = { fg = "#f8f8f6" },
    ["@string.escape"] = { fg = "#f8f8f6" },
    ["@string.special"] = { fg = "#f8f8f6" },
    ["@variable"] = { fg = "#e1ebb6" },
    ["@variable.parameter"] = { fg = "#f8f8f6" },
    ["@variable.builtin"] = { fg = "#e1ebb6" },
    ["@variable.member"] = { fg = "#74d5cf" },
    ["@variable.member.tsx"] = { fg = "#74d5cf" },
  },

  -- Vim syntax groups (language-agnostic)
  syntax = {
    Include = { fg = M.base_30.blue },
    Function = { fg = "#abd8c5" },
    Keyword = { fg = "#78adba" },
    Identifier = { fg = "#e1ebb6" },
    StorageClass = { fg = "#78adba" },
    Type = { fg = "#78adba" },
    Operator = { fg = "#78adba" },
    Delimiter = { fg = "#78adba" },
    typescriptIdentifierName = { fg = "#abd8c5" },
    -- Strings (Vim syntax)
    String = { fg = "#f8f8f6" },
    Character = { fg = "#f8f8f6" },
  },

  -- LSP semantic token accents for types
  semantic_tokens = {
    ["@lsp.type.type"] = { fg = "#78adba" },
    ["@lsp.type.interface"] = { fg = "#78adba" },
    ["@lsp.type.class"] = { fg = "#78adba" },
    -- Functions & methods via LSP semantic tokens
    ["@lsp.type.function"] = { fg = "#abd8c5" },
    ["@lsp.type.method"] = { fg = "#abd8c5" },
    ["@lsp.type.variable"] = { fg = "#e1ebb6" },
    ["@lsp.typemod.variable.declaration"] = { fg = "#e1ebb6" },
    ["@lsp.typemod.variable.readonly"] = { fg = "#e1ebb6" },
    ["@lsp.typemod.variable.local"] = { fg = "#e1ebb6" },
  },

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
