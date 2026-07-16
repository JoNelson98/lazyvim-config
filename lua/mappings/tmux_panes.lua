vim.keymap.set("n", "<leader>tp", "<cmd>Telescope tmux panes<CR>", { desc = "TMUX Panes" })
vim.keymap.set("n", "<leader>tw", "<cmd>Telescope tmux windows<CR>", { desc = "TMUX Windows" })
vim.keymap.set("n", "<leader>ts", "<cmd>Telescope tmux sessions<CR>", { desc = "TMUX Sessions" })
vim.keymap.set("n", "<leader>gg", function()
  vim.fn.system(
    "tmux run \"#{@popup-toggle} -w90% -h85% -Ed'#{pane_current_path}' --name=ghost fish\""
  )
end, {
  desc = "Toggle tmux ghost popup",
})
