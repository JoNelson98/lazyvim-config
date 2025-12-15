return {
  {
    "kamykn/spelunker.vim",
    lazy = false,
    cmd = {
      "ZL", "Zl", "ZC", "Zc", "ZF", "Zf",
      "ZN", "ZP", "ZT", "Zt",
      "SpelunkerAddAll",
    },
    config = function()
      vim.g.enable_spelunker_vim = 1
      vim.g.spelunker_check_type = 2
      vim.g.spelunker_target_min_char_len = 4
      vim.g.spelunker_disable_uri_checking = 1
      vim.g.spelunker_disable_email_checking = 1
      vim.g.spelunker_disable_account_name_checking = 1
      vim.g.spelunker_disable_acronym_checking = 1
      vim.opt.spell = false
    end,
    dependencies = {
      "kamykn/popup-menu.nvim",
    },
  },
}
