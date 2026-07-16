local map = vim.keymap.set

local function tmux_next_window()
  if not vim.env.TMUX or vim.env.TMUX == "" then
    return
  end
  if vim.fn.executable("tmux") ~= 1 then
    return
  end
  vim.fn.system({ "tmux", "next-window" })
end

-- Tmux navigation
map("n", "<S-h>", "<cmd>TmuxNavigateLeft<CR>", { desc = "window left" })
map("n", "<S-l>", "<cmd>TmuxNavigateRight<CR>", { desc = "window right" })
-- Same as prefix + l in tmux (next window)
map("n", ",,", tmux_next_window, { desc = "tmux: next window" })

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
