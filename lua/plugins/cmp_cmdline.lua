return {
  "hrsh7th/nvim-cmp",
  event = "InsertEnter",
  dependencies = {
    "hrsh7th/cmp-cmdline",
    "hrsh7th/cmp-nvim-lsp",
  },
  config = function()
    local cmp = require("cmp")
    local nvchad_cmp = require("nvchad.configs.cmp")

    -- Setup regular buffer completion (like command completion)
    cmp.setup(vim.tbl_deep_extend("force", nvchad_cmp, {
      sources = {
        { name = "nvim_lsp" }, -- FIRST for pylsp
        { name = "luasnip" },
        { name = "buffer" },
        { name = "nvim_lua" },
        { name = "async_path" },
      },
      mapping = vim.tbl_extend("force", nvchad_cmp.mapping or {}, {
        ["<A-j>"] = cmp.mapping.select_next_item { behavior = cmp.SelectBehavior.Insert },
        ["<A-k>"] = cmp.mapping.select_prev_item { behavior = cmp.SelectBehavior.Insert },
      }),
      -- Keep it minimal - disable documentation windows
      window = {
        documentation = cmp.config.window.bordered({
          border = "none",
          winhighlight = "Normal:Normal",
        }),
        completion = cmp.config.window.bordered({
          border = "none",
          winhighlight = "Normal:Normal",
        }),
      },
      -- Disable documentation popup
      view = {
        entries = { name = "custom", selection_order = "near_cursor" },
        docs = {
          auto_open = false, -- Don't auto-open docs
        },
      },
    }))

    -- `/` and `?` → buffer search completion
    cmp.setup.cmdline({ "/", "?" }, {
      mapping = cmp.mapping.preset.cmdline(),
      sources = {
        { name = "buffer" },
      },
    })

    -- -- `:` → command + path completion
    -- cmp.setup.cmdline(":", {
    --   mapping = cmp.mapping.preset.cmdline(),
    --   sources = cmp.config.sources(
    --     { { name = "path" } },
    --     { { name = "cmdline" } }
    --   ),
    -- })

    -- fallback if cmp UI ever dies
    vim.opt.wildmenu = true
    vim.opt.wildmode = { "longest:full", "full" }
  end,
}
