local map = vim.keymap.set

-- Cmdline abbreviations and core/general mappings
vim.cmd([[cabbrev go !go]])

local opts = { noremap = true, silent = true }

-- Window: jump to previous with <leader><leader>
map('n', '<leader><leader>', '<C-w>p', opts)

-- Disable problematic default Ctrl mappings
map("i", "<C-h>", "<nop>", { desc = "disabled" })
map("i", "<C-l>", "<nop>", { desc = "disabled" })
map("i", "<C-j>", "<nop>", { desc = "disabled" })
map("i", "<C-k>", "<nop>", { desc = "disabled" })
map("i", "<C-b>", "<nop>", { desc = "disabled" })
map("i", "<C-e>", "<nop>", { desc = "disabled" })

map("n", "<C-h>", "<nop>", { desc = "disabled" })
map("n", "<C-l>", "<nop>", { desc = "disabled" })
map("n", "<C-j>", "<nop>", { desc = "disabled" })
map("n", "<C-k>", "<nop>", { desc = "disabled" })
map("n", "<C-s>", "<nop>", { desc = "disabled" })
map("n", "<C-c>", "<nop>", { desc = "disabled" })
map("n", "<C-n>", "<nop>", { desc = "disabled" })

map("t", "<C-x>", "<nop>", { desc = "disabled" })

map("n", "<C-d>", "<nop>", { desc = "disabled" })
map("n", "<C-u>", "<nop>", { desc = "disabled" })

-- General
map("n", ";", ":", { desc = "CMD enter command mode" })



-- Scrolling: j=down, k=up (half page)
map("n", "<S-j>", "<C-d>zz", { desc = "scroll down half page" })
map("n", "<S-k>", "<C-u>zz", { desc = "scroll up half page" })

-- Insert navigation
map("i", "<A-h>", "<Left>", { desc = "move left" })
map("i", "<A-l>", "<Right>", { desc = "move right" })
map("i", "<A-b>", "<ESC>^i", { desc = "move beginning of line" })
map("i", "<A-e>", "<End>", { desc = "move end of line" })

-- Copy whole file
map("n", "<S-c>", "<cmd>%y+<CR>", { desc = "copy whole file" })

-- NvimTree toggle with Shift-n
map("n", "<S-n>", "<cmd>NvimTreeToggle<CR>", { desc = "nvimtree toggle window" })

-- Escape insert mode
map("i", "jk", "<ESC>", { desc = "Escape insert mode" })

-- Ensure K remains scroll-up in Go files (override vim-go doc mapping)
vim.api.nvim_create_autocmd("FileType", {
  pattern = "go",
  callback = function()
    vim.keymap.set("n", "K", "<C-u>zz", { buffer = true, desc = "scroll up half page" })
  end,
})

-- Type a backtick easily (keyboard without ` key)
-- Use Alt-1 for an ergonomic, widely-supported combo
map({ "i" }, "<A-1>", "`", { desc = "insert backtick" })
map({ "n", "o", "x" }, "<A-1>", "`", { desc = "backtick motion prefix" })
map({ "c" }, "<A-1>", "`", { desc = "cmdline backtick" })

-- Clean 'bb' -> '`' mapping (expr), avoids stray bytes and spacing issues
-- Only expands at a word boundary (not inside words like 'rabbit')
vim.keymap.set("i", "bb", function()
  local line = vim.api.nvim_get_current_line()
  local col = vim.fn.col(".") -- 1-based index AFTER the cursor position
  local prevch = (col - 1 >= 1) and line:sub(col - 1, col - 1) or ""
  if prevch == "" or not prevch:match("[%w_]") then
    return "`"
  else
    return "bb"
  end
end, { expr = true, noremap = true, desc = "bb -> ` (insert, word-boundary)" })

vim.keymap.set("c", "bb", function()
  local line = vim.fn.getcmdline()
  local pos = vim.fn.getcmdpos() - 1 -- index before cursor
  local prevch = (pos >= 1) and line:sub(pos, pos) or ""
  if prevch == "" or not prevch:match("[%w_]") then
    return "`"
  else
    return "bb"
  end
end, { expr = true, noremap = true, desc = "bb -> ` (cmdline, word-boundary)" })

-- picker for diagnostics
vim.keymap.set("n", "<leader>fd", function()
  require("snacks").picker.diagnostics()
end, { desc = "diagnostics (snacks)" })

vim.keymap.set("n", "<leader>fD", function()
  require("snacks").picker.diagnostics { bufnr = 0 }
end, { desc = "Buffer diagnostics (snacks)" })

vim.api.nvim_create_user_command("SnacksFiles", function()
  require("snacks").picker.files()
end, {})

vim.api.nvim_create_user_command("SnacksGrep", function()
  require("snacks").picker.grep()
end, {})

vim.api.nvim_create_user_command("SnacksWord", function()
  require("snacks").picker.grep {
    search = vim.fn.expand("<cword>"),
  }
end, {})
map("n", "<leader>ff", function()
  require("snacks").picker.files()
end, opts)

map("n", "<leader>fg", function()
  require("snacks").picker.grep()
end, opts)

map("n", "<leader>fw", function()
  require("snacks").picker.grep {
    search = vim.fn.expand("<cword>"),
  }
end, opts)

map("n", "<leader>st", function()
  require("utils.todosnacks").open()
end, { desc = "Snacks TODO picker" })

map("n", "<leader>fb", function()
  require("snacks").picker.buffers()
end, { desc = "Snacks: Buffers" })

map("n", "<leader>fr", function()
  require("snacks").picker.recent({ cwd_only = true })
end, { desc = "Snacks: Recent files" })

-- Diagnostics pickers (override NvChad defaults if they exist)
-- Use vim.schedule to ensure this runs after NvChad's mappings
vim.schedule(function()
  pcall(vim.keymap.del, "n", "<leader>dd")
  pcall(vim.keymap.del, "n", "<leader>dD")
  vim.keymap.set("n", "<leader>dd", function()
    require("snacks").picker.diagnostics()
  end, { desc = "Diagnostics (buffer)" })
  vim.keymap.set("n", "<leader>dD", function()
    require("snacks").picker.diagnostics_all()
  end, { desc = "Diagnostics (workspace)" })
end)
