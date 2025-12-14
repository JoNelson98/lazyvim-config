local M = {}

local function buildRgCmd(opts)
  local expression = "(" .. table.concat(opts.sign_list, "|") .. "):"

  if opts.match_comment_symbols then
    expression = [[([^\S\r\n]*(]]
        .. table.concat(opts.comment_symbols, "|")
        .. [[)[^\S\r\n]*)\s*(]]
        .. table.concat(opts.sign_list, "|")
        .. [[):\s*]]
  end

  return "rg -g '!{**/node_modules/*,**/.git/*}' -w '"
      .. expression
      .. "' "
      .. table.concat(opts.dirs, " ")
      .. " --hidden --follow --sortr modified --no-heading --color never --with-filename --line-number --column"
end

function M.get(opts)
  if not opts.sign_list or #opts.sign_list == 0 then
    return {}
  end

  local rg_res = vim.fn.systemlist(buildRgCmd(opts))
  local todos = {}

  for i, line in ipairs(rg_res) do
    local file, row, col, text = line:match("^(.+):(%d+):(%d+):(.*)$")
    if file then
      for _, sign in ipairs(opts.sign_list) do
        local s, e = text:find(sign .. ":")
        if s then
          table.insert(todos, {
            index = i,
            file = vim.trim(file),
            line = tonumber(row),
            sign = sign,
            desc = vim.trim(text:sub(e + 1)),
          })
          break
        end
      end
    end
    if #todos == opts.limit then break end
  end

  return todos
end

return M
