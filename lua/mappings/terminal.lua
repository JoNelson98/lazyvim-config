local map = vim.keymap.set

-- Tmux navigation
map("n", "<S-h>", "<cmd>TmuxNavigateLeft<CR>", { desc = "window left" })
map("n", "<S-l>", "<cmd>TmuxNavigateRight<CR>", { desc = "window right" })

-- NvChad terminal toggles
map({ "n", "t" }, "<leader>tt", function()
  require("nvchad.term").toggle { pos = "float", id = "floatTerm" }
end, { desc = "terminal toggle floating term" })

map({ "n", "t" }, "<leader>th", function()
  require("nvchad.term").toggle { pos = "sp", id = "htoggleTerm" }
end, { desc = "terminal toggle horizontal term" })

map({ "n", "t" }, "<leader>tv", function()
  require("nvchad.term").toggle { pos = "vsp", id = "vtoggleTerm" }
end, { desc = "terminal toggle vertical term" })

-- Terminal escape
map("t", "<A-x>", "<C-\\><C-N>", { desc = "terminal escape terminal mode" })
