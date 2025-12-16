return {
  "folke/todo-comments.nvim",
  lazy = false,
  dependencies = { "nvim-lua/plenary.nvim" },
  opts = {} -- use defaults
}

-- TODO: refactor this
-- NOTE: used by Odoo cron
-- HACK: workaround for upstream bug
-- FIX: handle nil case
-- WARN: this mutates state
