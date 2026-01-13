local M = {}

local function snacks_picker()
  return require("snacks.picker")
end

local function odoo_root()
  return vim.fn.getcwd()
end

function M.search_views()
  snacks_picker().grep({
    title = "Odoo Views (inherit / xpath)",
    cwd = odoo_root(),
    glob = { "**/*.xml" },
    regex = true,
    prompt = "inherit_id|xpath|field name",
  })
end

function M.search_models()
  snacks_picker().grep({
    title = "Odoo Models",
    cwd = odoo_root(),
    glob = { "**/*.py" },
    regex = true,
    prompt = "_name\\s*=|_inherit\\s*=",
  })
end

function M.search_fields()
  snacks_picker().grep({
    title = "Odoo Fields",
    cwd = odoo_root(),
    glob = { "**/*.py", "**/*.xml" },
    regex = true,
    prompt = "fields\\.|<field",
  })
end

function M.search_under_cursor()
  local word = vim.fn.expand("<cword>")
  snacks_picker().grep({
    title = "Odoo: " .. word,
    cwd = odoo_root(),
    search = word,
  })
end

return M
