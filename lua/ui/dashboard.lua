local Todos = require("ui.todos")

local M = {}

function M.sections()
  return {
    { section = "keys" },

    {
      pane = 1,
      section = "terminal",
      cmd = "img2art ~/.config/nvim/lua/plugins/dashboard_img/hq.png --threshold 50 --scale .34 --quant 16 --with-color",
      height = 27,
      width = 100,
      indent = 20,
    },

    {
      pane = 2,
      indent = 21,

      {
        {
          text = {
            { "f ", hl = "key" }, { "Find file", hl = "Normal" },
            { "",   width = 10 },
            { "g ", hl = "key" }, { "Grep text", hl = "Normal" },
          },
        },
        { text = "", padding = 1 },
        {
          text = {
            { "r ", hl = "key" }, { "Recent files", hl = "Normal" },
            { "",   width = 6 },
            { "L ", hl = "key" }, { "Lazy", hl = "Normal" },
          },
        },
      },

      { text = "",            padding = 2 },
      { title = "Projects",   padding = 1, indent = 21 },
      { section = "projects", limit = 5,   padding = 2, indent = 20 },

      { title = "TODO List",  padding = 1, indent = 21 },

      {
        indent = 21,
        function()
          local todos = Todos.get {
            limit = 5,
            match_comment_symbols = true,
            comment_symbols = { "--", "//", "#", "/*" },
            dirs = { "~/.config", "~/code" },
            sign_list = { "TODO", "FIX", "FIXME", "BUG", "ERROR" },
          }

          return vim.tbl_map(function(todo)
            return {
              autokey = true,
              text = {
                { todo.index .. " ",    hl = "key" },
                { todo.sign .. " ",     hl = "NonText" },
                { todo.desc:sub(1, 35), hl = "Normal" },
              },
              action = function()
                vim.cmd("edit " .. todo.file)
                vim.cmd(todo.line)
              end,
            }
          end, todos)
        end,
      },
    },
  }
end

return M
