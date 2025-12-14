local M = {}

function M.setup()
  local alpha = require("alpha")
  local dashboard = require("alpha.themes.dashboard")

  -- 🔁 animated header (FULL control lives here)
  local frames = {
    {
      "   Lock in FN   ",
    },
    {
      "  > Lock in FN  ",
    },
    {
      " >> Lock in FN ",
    },
    {
      ">>> Lock in FN ",
    },
  }

  local frame = 1
  dashboard.section.header.val = frames[frame]

  local timer = vim.loop.new_timer()
  timer:start(
    0,
    120,
    vim.schedule_wrap(function()
      frame = frame % #frames + 1
      dashboard.section.header.val = frames[frame]
      alpha.redraw()
    end)
  )

  -- 🧭 buttons (also live here)
  dashboard.section.buttons.val = {
    dashboard.button("f", "  Find Files", "<cmd>SnacksFiles<CR>"),
    dashboard.button("g", "󰈞  Live Grep", "<cmd>SnacksGrep<CR>"),
    dashboard.button("w", "󰈞  Find Word", "<cmd>SnacksWord<CR>"),
    dashboard.button("L", "󰆧  Lazy sync", "<cmd>Lazy sync<CR>"),
    dashboard.button("G", "  Lazy Git", "<cmd>LazyGit<CR>"),
    dashboard.button("q", "  Quit", "<cmd>qa<CR>"),
  }
  alpha.setup(dashboard.config)
end

return M
