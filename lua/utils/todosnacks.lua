local M = {}

function M.open()
  -- Populate quickfix silently
  vim.cmd("silent TodoQuickFix")

  local qf = vim.fn.getqflist()
  vim.cmd("cclose")

  if not qf or vim.tbl_isempty(qf) then
    vim.notify("No TODO comments found", vim.log.levels.INFO)
    return
  end

  local items = {}
  for _, item in ipairs(qf) do
    table.insert(items, {
      text = item.text,
      file = item.filename,
      line = item.lnum,
      col = item.col or 0,
    })
  end

  require("snacks").picker({
    title = "TODOs",
    items = items,

    format = function(it)
      return string.format(
        "%s:%d  %s",
        vim.fn.fnamemodify(it.file, ":."),
        it.line,
        it.text
      )
    end,

    on_select = function(it)
      vim.cmd.edit(it.file)
      vim.api.nvim_win_set_cursor(0, { it.line, it.col })
    end,
  })
end

return M
