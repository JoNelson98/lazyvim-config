local M = {}

function M.apply()
  -- NOTE: python-only keyword highlight overrides (tweak colors here).
  -- Only apply for Evergarden to avoid clashing with other themes.
  if vim.g.colors_name ~= "evergarden" then
    return
  end
  local palette = {
    red = "#e67e80",
    orange = "#e69875",
    yellow = "#dbbc7f",
    green = "#a7c080",
    aqua = "#83c092",
    blue = "#7fbbb3",
    purple = "#d699b6",
    gray = "#859289",
  }

  local set_hl = vim.api.nvim_set_hl

  set_hl(0, "@keyword.import.python", { fg = palette.blue, bold = true })
  set_hl(0, "@keyword.function.python", { fg = palette.green, bold = true })
  set_hl(0, "@keyword.type.python", { fg = palette.yellow, bold = true })
  set_hl(0, "@keyword.return.python", { fg = palette.red, bold = true })
  set_hl(0, "@keyword.conditional.python", { fg = palette.purple, italic = true })
  set_hl(0, "@keyword.repeat.python", { fg = palette.orange })
  set_hl(0, "@keyword.exception.python", { fg = palette.red, italic = true })
  set_hl(0, "@keyword.coroutine.python", { fg = palette.aqua, bold = true })
  set_hl(0, "@keyword.operator.python", { fg = palette.aqua })
  set_hl(0, "@keyword.scope.python", { fg = palette.gray, italic = true })
end

return M
