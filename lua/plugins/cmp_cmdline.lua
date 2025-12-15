return {
  "hrsh7th/nvim-cmp",
  dependencies = {
    "hrsh7th/cmp-cmdline",
  },
  config = function()
    local cmp = require("cmp")

    -- `/` and `?` → buffer search completion
    cmp.setup.cmdline({ "/", "?" }, {
      mapping = cmp.mapping.preset.cmdline(),
      sources = {
        { name = "buffer" },
      },
    })

    -- `:` → command + path completion
    cmp.setup.cmdline(":", {
      mapping = cmp.mapping.preset.cmdline(),
      sources = cmp.config.sources(
        { { name = "path" } },
        { { name = "cmdline" } }
      ),
    })

    -- fallback if cmp UI ever dies
    vim.opt.wildmenu = true
    vim.opt.wildmode = { "longest:full", "full" }
  end,
}
