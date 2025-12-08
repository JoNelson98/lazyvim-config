local actions = require("telescope.actions")

return function(opts)
  opts = opts or {}
  opts.defaults = opts.defaults or {}

  opts.defaults.layout_strategy = "flex"
  opts.defaults.layout_config = vim.tbl_deep_extend("force", opts.defaults.layout_config or {}, {
    preview_cutoff = 1,
    width = function(_, max_cols)
      return max_cols
    end,
    height = function(_, max_lines)
      return max_lines
    end,
  })

  opts.defaults.mappings = vim.tbl_deep_extend("force", opts.defaults.mappings or {}, {
    i = {
      ["<S-j>"] = actions.move_selection_next,
      ["<S-k>"] = actions.move_selection_previous,
    },
    n = {
      ["J"] = actions.move_selection_next,
      ["K"] = actions.move_selection_previous,
    },
  })
  return opts
end
