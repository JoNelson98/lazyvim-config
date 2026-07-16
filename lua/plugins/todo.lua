return {
  "folke/todo-comments.nvim",
  lazy = false,
  dependencies = { "nvim-lua/plenary.nvim" },
  opts = {}, -- use defaults
  config = function(_, opts)
    require("todo-comments").setup(opts)

    -- Reapply highlights after colorscheme changes.
    local group = vim.api.nvim_create_augroup("TodoCommentsColorscheme", { clear = true })
    vim.api.nvim_create_autocmd("ColorScheme", {
      group = group,
      callback = function()
        require("todo-comments").setup(opts)
      end,
    })
  end,
}

-- TODO: refactor this
-- NOTE: used by Odoo cron
-- HACK: workaround for upstream bug
-- FIX: handle nil case
-- WARN: this mutates state
