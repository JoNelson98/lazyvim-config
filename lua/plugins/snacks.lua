return {
  "folke/snacks.nvim",
  priority = 1000,
  lazy = false,
  opts = {
    dashboard = {
      enabled = false,
      width = 100,
      pane_gap = 20,
      autokeys = "1234567890abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ",
      -- sections = require("ui.dashboard").sections(),
    },
    bigfile = { enabled = true },
    indent = { enabled = true },
    input = { enabled = true },
    lazygit = { enabled = true },
    notifier = { enabled = true },
    picker = {
      enabled = true,
      layout = "telescope", -- This layout has input at the bottom
    },
    quickfile = { enabled = true },
    scroll = { enabled = false },
    statuscolumn = { enabled = false },
    words = { enabled = true },
  },
  config = function(_, opts)
    require("snacks").setup(opts)
    vim.api.nvim_set_hl(0, "SnacksDashboardKey", { fg = "#5ceef6" })
    vim.api.nvim_set_hl(0, "SnacksDashboardTitle", { fg = "#c49aee" })

    local bg = "#101010" -- NOT pitch black, editor-ish
    local fg = "NONE"

    -- Input box
    vim.api.nvim_set_hl(0, "SnacksPickerInput", { bg = bg, fg = fg })
    vim.api.nvim_set_hl(0, "SnacksPickerInputCursor", { bg = bg, fg = fg })

    -- Results list
    vim.api.nvim_set_hl(0, "SnacksPickerList", { bg = bg, fg = fg })
    vim.api.nvim_set_hl(0, "SnacksPickerListItem", { bg = bg, fg = fg })
    vim.api.nvim_set_hl(0, "SnacksPickerListItemSelected", {
      bg = "#181818", fg = fg,
    })

    -- Preview pane
    vim.api.nvim_set_hl(0, "SnacksPickerPreview", { bg = bg, fg = fg })
    -- Set snack picker colors to match editor background
    -- vim.api.nvim_set_hl(0, "SnacksPickerNormal", { bg = editor_bg, fg = "NONE" })
    -- vim.api.nvim_set_hl(0, "SnacksPickerBorder", { bg = editor_bg, fg = editor_bg })
    -- vim.api.nvim_set_hl(0, "SnacksPickerPromptNormal", { bg = editor_bg, fg = "NONE" })
    -- vim.api.nvim_set_hl(0, "SnacksPickerResultsNormal", { bg = editor_bg, fg = "NONE" })
    -- vim.api.nvim_set_hl(0, "SnacksPickerPreviewNormal", { bg = editor_bg, fg = "NONE" })
    -- vim.api.nvim_set_hl(0, "SnacksPickerPromptBorder", { bg = editor_bg, fg = editor_bg })
    -- vim.api.nvim_set_hl(0, "SnacksPickerResultsBorder", { bg = editor_bg, fg = editor_bg })
    -- vim.api.nvim_set_hl(0, "SnacksPickerPreviewBorder", { bg = editor_bg, fg = editor_bg })
  end,
}
