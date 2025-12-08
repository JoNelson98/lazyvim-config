local map = vim.keymap.set

-- Snippet or completion forward/backward
map({ "i", "s" }, "<A-j>", function()
  local ok, ls = pcall(require, "luasnip")
  if ok and ls.jumpable(1) then
    ls.jump(1)
  else
    local cmp = require("cmp")
    cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Insert })()
  end
end, { desc = "Next snippet or completion item" })

map({ "i", "s" }, "<A-k>", function()
  local ok, ls = pcall(require, "luasnip")
  if ok and ls.jumpable(-1) then
    ls.jump(-1)
  else
    local cmp = require("cmp")
    cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Insert })()
  end
end, { desc = "Prev snippet or completion item" })
