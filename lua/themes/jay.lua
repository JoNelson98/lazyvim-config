local M = {}

-- UI + Syntax swatches
M.base_30 = {
  white = "#d7dae0", -- default text / variables
  black = "#2b2f33", -- editor bg (dark pastel grey)
  darker_black = "#262b30", -- bg for splits / line numbers bg
  black2 = "#30353b", -- statusline bg
  one_bg = "#333940", -- one step lighter than bg
  one_bg2 = "#3a4048", -- another step lighter
  one_bg3 = "#414851", -- yet another lighter
  grey = "#7d8494", -- operators/punctuation (=, ~=, ==, .., :, etc.)
  grey_fg = "#8a91a2", -- subtle grey text
  grey_fg2 = "#979fb1", -- even lighter grey
  light_grey = "#a5adbf", -- inactive UI icons/edges
  red = "#9F585F", -- “type” red or builtin function
  baby_pink = "#f38fb9", -- accent pink
  pink = "#e67acb", -- keywords (if, then, end, for, do, in)
  line = "#383e46", -- line highlight
  green = "#959876", -- properties/fields (.text, .items, .id)
  vibrant_green = "#77AFA7", -- bright green accent
  nord_blue = "#82A5CF", -- alt blue
  blue = "#82A5CF", -- function calls (gsub, getqflist, execute)
  seablue = "#6cb8ff", -- alt blue accent
  yellow = "#FFD67C", -- “function” keyword
  purple = "#AE83AB", -- local/return/in
  dark_purple = "#8f6be3", -- purple variant
  teal = "#42c9bd", -- teal accent
  orange = "#e8a067", -- numbers, booleans (true/false)
  cyan = "#52d4ff", -- cyan accent
  statusline_bg = "#30353b", -- statusline background
  lightbg = "#3a4048", -- lighter float background
  pmenu_bg = "#4a90ff", -- popup menu selected item bg
  folder_bg = "#4a90ff", -- folder icons
}

-- Base16: drives defaults for syntax + plugins
M.base_16 = {
  base00 = "#2b2f33", -- editor background (dark pastel grey)
  base01 = "#32363c", -- lighter bg
  base02 = "#383e46", -- selection bg
  base03 = "#4a4f57", -- comments
  base04 = "#b5bac9", -- light grey for status text
  base05 = "#d7dae0", -- default foreground (variables, plain text)
  base06 = "#e4e6eb", -- brighter fg
  base07 = "#f2f4f7", -- brightest fg
  base08 = "#e2555a", -- identifiers/types you want red
  base09 = "#e8a067", -- numbers/booleans
  base0A = "#f6c452", -- function keyword
  base0B = "#5fcf74", -- strings (lime green)
  base0C = "#42c9bd", -- tealish types
  base0D = "#4a90ff", -- function calls
  base0E = "#e67acb", -- keywords
  base0F = "#979fb1", -- extra grey
}

-- Exact token overrides for your mapping
M.polish_hl = {
  treesitter = {
    ["@keyword"] = { fg = M.base_30.purple }, -- if/then/end/do/for/in
    ["@keyword.function"] = { fg = M.base_30.yellow }, -- function keyword
    ["@string"] = { fg = M.base_30.green }, -- lime-green strings
    ["@number"] = { fg = M.base_30.orange }, -- numbers
    ["@boolean"] = { fg = M.base_30.orange }, -- true/false
    ["@operator"] = { fg = M.base_30.grey }, -- == ~= .. =
    ["@punctuation.delimiter"] = { fg = M.base_30.grey },
    ["@punctuation.bracket"] = { fg = M.base_30.grey },
    ["@function.call"] = { fg = M.base_30.blue }, -- gsub, getqflist
    ["@function.builtin"] = { fg = M.base_30.red }, -- type()
    ["@property"] = { fg = M.base_30.green }, -- .text, .items
    ["@field"] = { fg = M.base_30.green },
    ["@variable"] = { fg = M.base_30.white }, -- val, idx, response
    ["@variable.parameter"] = { fg = M.base_30.white },
    ["@type"] = { fg = M.base_30.red }, -- type hints
  },
}

M.type = "dark"
M = require("base46").override_theme(M, "jay")
return M
