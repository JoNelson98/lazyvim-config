local term   = require("odoo.term")
local cmd    = require("odoo.commands")
local picker = require("odoo.picker")

local M      = {}

function M.setup()
  local map = vim.keymap.set

  -- Server
  map("n", "<leader>os", term.toggle_server, { desc = "Odoo: toggle server" })
  map("n", "<leader>or", term.restart_server, { desc = "Odoo: restart server" })

  -- Shell
  map("n", "<leader>osh", term.toggle_shell, { desc = "Odoo: shell" })

  -- Search / jump (FIXED names)
  map("n", "<leader>ov", picker.views, { desc = "Odoo: find views" })
  map("n", "<leader>om", picker.models, { desc = "Odoo: find models" })
  map("n", "<leader>of", picker.fields, { desc = "Odoo: find fields" })

  -- Upgrade current module (Fish + venv aware)
  map("n", "<leader>ou", function()
    local module = cmd.current_module()
    if not module then return end

    local cmdline = string.format(
      [[fish -c "source ~/odoo/code/venv.macos/bin/activate.fish; python3 ~/odoo/code/ilf-odoo15/odoo/odoo-bin -c ~/odoo/confg/staging.conf -u %s"]],
      module
    )

    require("toggleterm").exec(cmdline)
  end, { desc = "Odoo: upgrade module" })
end

return M
