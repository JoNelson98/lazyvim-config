return {
  "akinsho/toggleterm.nvim",
  version = "*",
  keys = {
    {
      '<leader>"',
      function()
        require("toggleterm").toggle(1)
      end,
      desc = "Toggle terminal (persistent)",
    },
  },
  opts = {
    direction = "float",
    start_in_insert = true,
    persist_mode = true,
    persist_size = true,
    close_on_exit = false, -- IMPORTANT
    float_opts = {
      border = "rounded",
    },
  },
  config = function(_, opts)
    require("toggleterm").setup(opts)

    -- ESC leaves terminal mode but DOES NOT close it
    vim.keymap.set("t", "<Esc>", [[<C-\><C-n>]], { silent = true })

    -- Optional: hide terminal with same key while focused
    vim.keymap.set("t", '<leader>"', [[<C-\><C-n><cmd>ToggleTerm<CR>]])
  end,
}
