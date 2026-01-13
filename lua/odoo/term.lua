local M = {}

local function term()
  return require("toggleterm.terminal").Terminal
end

local function fish_cmd(cmd)
  return string.format(
    'fish -c "source ~/odoo/code/venv.macos/bin/activate.fish; %s"',
    cmd
  )
end

local function odoo()
  return "python3 ~/odoo/code/ilf-odoo15/odoo/odoo-bin -c ~/odoo/confg/staging.conf"
end

function M.toggle_server()
  M._server = M._server or term():new({
    cmd = fish_cmd(odoo()),
    direction = "float",
    close_on_exit = false,
    hidden = true,
  })
  M._server:toggle()
end

function M.restart_server()
  if M._server and M._server:is_open() then
    M._server:shutdown()
  end
  M.toggle_server()
end

function M.toggle_shell()
  M._shell = M._shell or term():new({
    cmd = fish_cmd(odoo() .. " shell"),
    direction = "float",
    close_on_exit = false,
    hidden = true,
  })
  M._shell:toggle()
end

return M
