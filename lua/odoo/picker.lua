local picker = require("snacks.picker")

local M = {}

local function odoo_root()
  return vim.fn.getcwd()
end

function M.search_views()
  picker.grep({
    title = "Odoo Views (inherit / xpath)",
    cwd = odoo_root(),
    glob = { "**/*.xml" },
    regex = true,
    prompt = "inherit_id|xpath|field name",
  })
end

function M.search_models()
  picker.grep({
    title = "Odoo Models",
    cwd = odoo_root(),
    glob = { "**/*.py" },
    regex = true,
    prompt = "_name\\s*=|_inherit\\s*=",
  })
end

function M.search_fields()
  picker.grep({
    title = "Odoo Fields",
    cwd = odoo_root(),
    glob = { "**/*.py", "**/*.xml" },
    regex = true,
    prompt = "fields\\.|<field",
  })
end

return M
