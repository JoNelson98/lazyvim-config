local Terminal = require("toggleterm.terminal").Terminal

local M = {}

local FISH = "fish -c"

local VENV = "source ~/odoo/code/venv.macos/bin/activate.fish"
local ODOO = "python3 ~/odoo/code/ilf-odoo15/odoo/odoo-bin"
local CONF = "-c ~/odoo/confg/staging.conf"

local function fish_cmd(cmd)
  return string.format('%s "%s; %s"', FISH, VENV, cmd)
end

M.server = Terminal:new({
  cmd = fish_cmd(string.format("%s %s", ODOO, CONF)),
  direction = "float",
  close_on_exit = false,
  hidden = true,
})

M.shell = Terminal:new({
  cmd = fish_cmd(string.format("%s shell %s", ODOO, CONF)),
  direction = "float",
  close_on_exit = false,
  hidden = true,
})

function M.toggle_server()
  M.server:toggle()
end

function M.restart_server()
  if M.server:is_open() then
    M.server:shutdown()
  end
  M.server:open()
end

function M.toggle_shell()
  M.shell:toggle()
end

return M
