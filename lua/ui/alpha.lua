local M = {}

function M.setup()
  local alpha = require("alpha")
  local dashboard = require("alpha.themes.dashboard")

  dashboard.section.header.val = {
    ' ███╗   ██╗ ███████╗ ██████╗  ██╗   ██╗ ██╗ ███╗   ███╗',
    ' ████╗  ██║ ██╔════╝██╔═══██╗ ██║   ██║ ██║ ████╗ ████║',
    ' ██╔██╗ ██║ █████╗  ██║   ██║ ██║   ██║ ██║ ██╔████╔██║',
    ' ██║╚██╗██║ ██╔══╝  ██║   ██║ ╚██╗ ██╔╝ ██║ ██║╚██╔╝██║',
    ' ██║ ╚████║ ███████╗╚██████╔╝  ╚████╔╝  ██║ ██║ ╚═╝ ██║',
    ' ╚═╝  ╚═══╝ ╚══════╝ ╚═════╝    ╚═══╝   ╚═╝ ╚═╝     ╚═╝',

  }


  dashboard.section.buttons.val = {
    dashboard.button("f", "  Find Files", "<cmd>SnacksFiles<CR>"),
    dashboard.button("g", "󰈞  Live Grep", "<cmd>SnacksGrep<CR>"),
    dashboard.button("r", "󰄉  Recent Files", "<cmd>lua require('snacks').picker.recent()<CR>"),
    dashboard.button("p", "󰏗  Projects", "<cmd>lua require('snacks').picker.projects()<CR>"),
    dashboard.button("L", "󰆧  Lazy sync", "<cmd>Lazy sync<CR>"),
    dashboard.button("G", "  Lazy Git", "<cmd>LazyGit<CR>"),
    dashboard.button("q", "  Quit", "<cmd>qa<CR>"),
  }
  local function footer()
    return "Don't Stop Unitl You are Proud..."
  end

  dashboard.section.footer.val = footer()
  alpha.setup(dashboard.config)
end

return M
