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

    local function hl_exists(name)
      local ok, hl = pcall(vim.api.nvim_get_hl, 0, { name = name })
      return ok and hl and not vim.tbl_isempty(hl)
    end

    local function link(from, to)
      vim.api.nvim_set_hl(0, from, { link = to })
    end

    local function apply_snacks_hl()
      -- Prefer Evergarden's "Pick*" groups when available (they match the theme's picker UI).
      local use_pick = hl_exists("PickNormal") and hl_exists("PickBorder") and hl_exists("PickTitle")

      if use_pick then
        link("SnacksDashboardKey", "PickPointer")
        link("SnacksDashboardTitle", "PickTitle")

        link("SnacksPickerInput", "PickNormal")
        link("SnacksPickerInputCursor", "PickSel")

        link("SnacksPickerList", "PickNormal")
        link("SnacksPickerListItem", "PickNormal")
        link("SnacksPickerListItemSelected", "PickSel")

        link("SnacksPickerInputBorder", "PickBorder")
        link("SnacksPickerTitle", "PickTitle")
        link("SnacksPickerListTitle", "PickTitle")
        link("SnacksPickerPreviewTitle", "PickTitle")

        link("SnacksPickerPreview", "PickNormal")
        return
      end

      -- Generic fallback for other colorschemes.
      link("SnacksDashboardKey", "Special")
      link("SnacksDashboardTitle", "Title")

      link("SnacksPickerInput", "NormalFloat")
      link("SnacksPickerInputCursor", "CursorLine")

      link("SnacksPickerList", "NormalFloat")
      link("SnacksPickerListItem", "NormalFloat")
      link("SnacksPickerListItemSelected", "PmenuSel")

      link("SnacksPickerInputBorder", "FloatBorder")
      link("SnacksPickerTitle", "FloatTitle")
      link("SnacksPickerListTitle", "FloatTitle")
      link("SnacksPickerPreviewTitle", "FloatTitle")

      link("SnacksPickerPreview", "NormalFloat")
    end

    -- Colorschemes (including Evergarden) reset highlights on `:colorscheme`,
    -- so re-apply after every colorscheme change.
    vim.api.nvim_create_autocmd("ColorScheme", {
      group = vim.api.nvim_create_augroup("SnacksThemeHighlights", { clear = true }),
      callback = apply_snacks_hl,
    })

    -- Apply once for current theme.
    vim.schedule(apply_snacks_hl)
  end,
}
