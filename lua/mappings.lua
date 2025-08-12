require "nvchad.mappings"




local map = vim.keymap.set


-- for go ex command
vim.cmd([[cabbrev go !go]])


-- cmd split pane jumps
local opts = { noremap = true, silent = true }
map('n', '<leader><leader>', '<C-w>p', opts)
-- Snippet or Completion forward
map({ "i", "s" }, "<A-j>", function()
  local ok, ls = pcall(require, "luasnip")
  if ok and ls.jumpable(1) then
    ls.jump(1)
  else
    local cmp = require("cmp")
    cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Insert })()
  end
end, { desc = "Next snippet or completion item" })

-- Snippet or Completion backward
map({ "i", "s" }, "<A-k>", function()
  local ok, ls = pcall(require, "luasnip")
  if ok and ls.jumpable(-1) then
    ls.jump(-1)
  else
    local cmp = require("cmp")
    cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Insert })()
  end
end, { desc = "Prev snippet or completion item" })
-- add yours here


-- Disable problematic default Ctrl mappings first
-- Insert mode navigation - disable default Ctrl bindings
map("i", "<C-h>", "<nop>", { desc = "disabled" })
map("i", "<C-l>", "<nop>", { desc = "disabled" })
map("i", "<C-j>", "<nop>", { desc = "disabled" })
map("i", "<C-k>", "<nop>", { desc = "disabled" })
map("i", "<C-b>", "<nop>", { desc = "disabled" })
map("i", "<C-e>", "<nop>", { desc = "disabled" })

-- Normal mode - disable default Ctrl window navigation
map("n", "<C-h>", "<nop>", { desc = "disabled" })
map("n", "<C-l>", "<nop>", { desc = "disabled" })
map("n", "<C-j>", "<nop>", { desc = "disabled" })
map("n", "<C-k>", "<nop>", { desc = "disabled" })
map("n", "<C-s>", "<nop>", { desc = "disabled" })
map("n", "<C-c>", "<nop>", { desc = "disabled" })
map("n", "<C-n>", "<nop>", { desc = "disabled" })

-- Terminal mode - disable Ctrl-x
map("t", "<C-x>", "<nop>", { desc = "disabled" })

-- Page scrolling - disable default Ctrl+d/u
map("n", "<C-d>", "<nop>", { desc = "disabled" })
map("n", "<C-u>", "<nop>", { desc = "disabled" })

-- MORE ERGONOMIC REPLACEMENTS
-- General mappings
map("n", ";", ":", { desc = "CMD enter command mode" })

-- Window/Tmux navigation with Shift + h/l
map("n", "<S-h>", "<cmd>TmuxNavigateLeft<CR>", { desc = "window left" })
map("n", "<S-l>", "<cmd>TmuxNavigateRight<CR>", { desc = "window right" })
-- Page scrolling with Shift + j/k
map("n", "<S-j>", "<C-d>zz", { desc = "scroll down half page" })
map("n", "<S-k>", "<C-u>zz", { desc = "scroll up half page" })

-- Insert mode navigation with Alt + hjkl (very ergonomic on Mac!)
map("i", "<A-h>", "<Left>", { desc = "move left" })
map("i", "<A-l>", "<Right>", { desc = "move right" })
-- removed up and down for now
map("i", "<A-b>", "<ESC>^i", { desc = "move beginning of line" })
map("i", "<A-e>", "<End>", { desc = "move end of line" })

-- Avoid using Shift + s/S because leap.nvim uses these
map("n", "<S-c>", "<cmd>%y+<CR>", { desc = "copy whole file" })

-- (Replaced by Shift + j/k)

-- NvimTree with Shift-n (easier than Ctrl-n)
map("n", "<S-n>", "<cmd>NvimTreeToggle<CR>", { desc = "nvimtree toggle window" })

-- Terminal escape with Alt-x (much easier!)
map("t", "<A-x>", "<C-\\><C-N>", { desc = "terminal escape terminal mode" })

-- Terminal mappings (all toggleable!)
map({ "n", "t" }, "<leader>tt", function()
  require("nvchad.term").toggle { pos = "float", id = "floatTerm" }
end, { desc = "terminal toggle floating term" })

map({ "n", "t" }, "<leader>th", function()
  require("nvchad.term").toggle { pos = "sp", id = "htoggleTerm" }
end, { desc = "terminal toggle horizontal term" })

map({ "n", "t" }, "<leader>tv", function()
  require("nvchad.term").toggle { pos = "vsp", id = "vtoggleTerm" }
end, { desc = "terminal toggle vertical term" })

-- Insert mode mappings
map("i", "jk", "<ESC>", { desc = "Escape insert mode" })
