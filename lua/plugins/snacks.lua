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
      focus = "list",       -- Open picker on results list (normal-mode navigation)
      sources = {
        files = {
          ignored = true,
          hidden = true,
        },
      },
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

      link("SnacksPickerInput", "Normal")
      link("SnacksPickerInputCursor", "CursorLine")

      link("SnacksPickerList", "Normal")
      link("SnacksPickerListItem", "Normal")
      link("SnacksPickerListItemSelected", "PmenuSel")

      local border_fg = "#505050"
      local ok, hl_comment = pcall(vim.api.nvim_get_hl, 0, { name = "Comment" })
      if ok and hl_comment and hl_comment.fg then
        border_fg = string.format("#%06x", hl_comment.fg)
      end
      vim.api.nvim_set_hl(0, "SnacksPickerInputBorder", { fg = border_fg, bg = "NONE" })

      link("SnacksPickerTitle", "Title")
      link("SnacksPickerListTitle", "Title")
      link("SnacksPickerPreviewTitle", "Title")

      link("SnacksPickerPreview", "Normal")

      -- Horizon: nudge border + results text only.
      if vim.g.colors_name == "horizon" then
        local ok, base46 = pcall(require, "base46")
        if ok then
          local c = base46.get_theme_tb("base_30") or {}
          local orange = c.orange or c.sun or "NONE"
          local fg = c.white or "NONE"
          vim.api.nvim_set_hl(0, "SnacksPickerInputBorder", { fg = orange })
          vim.api.nvim_set_hl(0, "SnacksPickerListTitle", { fg = orange })
          vim.api.nvim_set_hl(0, "SnacksPickerListItem", { fg = fg })
          vim.api.nvim_set_hl(0, "SnacksPickerList", { fg = fg })

          -- Make file paths readable in results (orange accents for path parts).
          vim.api.nvim_set_hl(0, "SnacksPickerFile", { fg = fg })
          vim.api.nvim_set_hl(0, "SnacksPickerDirectory", { fg = orange })
          vim.api.nvim_set_hl(0, "SnacksPickerDir", { fg = orange })
          vim.api.nvim_set_hl(0, "SnacksPickerPathHidden", { fg = orange })
          vim.api.nvim_set_hl(0, "SnacksPickerPathIgnored", { fg = orange })
        end
      end
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
