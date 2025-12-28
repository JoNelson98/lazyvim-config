local M = {}

-- Walk up directories until we find __manifest__.py
local function find_manifest_dir(start_dir)
  local dir = start_dir

  while dir and dir ~= "/" do
    local manifest = dir .. "/__manifest__.py"
    if vim.fn.filereadable(manifest) == 1 then
      return dir
    end
    dir = vim.fn.fnamemodify(dir, ":h")
  end
end

-- Return current Odoo module name based on buffer location
function M.current_module()
  local buf = vim.api.nvim_buf_get_name(0)
  if buf == "" then
    vim.notify("No buffer file", vim.log.levels.ERROR)
    return nil
  end

  local start_dir = vim.fn.fnamemodify(buf, ":h")
  local manifest_dir = find_manifest_dir(start_dir)

  if not manifest_dir then
    vim.notify("Not inside an Odoo module (__manifest__.py not found)", vim.log.levels.ERROR)
    return nil
  end

  -- module name = directory containing __manifest__.py
  return vim.fn.fnamemodify(manifest_dir, ":t")
end

return M
