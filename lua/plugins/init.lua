return {
  { "dasupradyumna/midnight.nvim", lazy = false },
  {
    "goolord/alpha-nvim",
    lazy = false,
    priority = 2000,
    config = function()
      require("ui.alpha").setup()
    end
  },
  {
    "folke/flash.nvim",
    event = "VeryLazy",
    --@type Flash.Config
    opts = {},
    keys = {
      {
        "s",
        mode = { "n", "x", "o" },
        function()
          require("flash").jump()
        end,
        desc = "Flash",
      },
      {
        "S",
        mode = { "n", "x", "o" },
        function()
          require("flash").treesitter()
        end,
        desc = "Flash Treesitter",
      },
      {
        "r",
        mode = "o",
        function()
          require("flash").remote()
        end,
        desc = "Remote Flash",
      },
      {
        "R",
        mode = { "o", "x" },
        function()
          require("flash").treesitter_search()
        end,
        desc = "Treesitter Search",
      },
      {
        "<c-s>",
        mode = { "c" },
        function()
          require("flash").toggle()
        end,
        desc = "Toggle Flash Search",
      },
    },
  },
  {
    "fatih/vim-go",
    ft = "go",
    build = ":GoInstallBinaries",
    config = function()
      vim.g.go_fmt_command = "goimports"
      -- Disable vim-go overriding 'K' for godoc so our scroll mapping works
      vim.g.go_doc_keywordprg_enabled = 0
      -- Also disable default definition mappings to prevent surprises
      vim.g.go_def_mapping_enabled = 0
    end,
  },

  {
    "ray-x/go.nvim",
    ft = { "go", "gomod" },
    dependencies = {
      "ray-x/guihua.lua",
      "nvim-treesitter/nvim-treesitter",
      "neovim/nvim-lspconfig",
    },
    build = ":lua require('go.install').update_all_sync()",
    config = require "configs.go",
  },
  {
    "nvim-tree/nvim-tree.lua",
    cmd = { "NvimTreeToggle", "NvimTreeFocus", "NvimTreeFindFile", "NvimTreeOpen", "NvimTreeClose" },
    opts = require "configs.nvimtree",
  },

  {
    "nvim-telescope/telescope.nvim",
    cmd = "Telescope",
    keys = {
      {
        "<leader>fb",
        function() require("telescope.builtin").buffers() end,
        desc = "Buffers",
      },
      {
        "<leader>fh",
        function() require("telescope.builtin").help_tags() end,
        desc = "Help tags",
      },
    },
    opts = function(_, opts)
      return require("configs.telescope")(opts)
    end,
  },
  {
    "christoomey/vim-tmux-navigator",
    event = "VeryLazy",
    cmd = { "TmuxNavigateLeft", "TmuxNavigateRight", "TmuxNavigateUp", "TmuxNavigateDown" },
  },
  {
    "ThePrimeagen/vim-be-good",
    lazy = true,
  },
  {
    "kawre/leetcode.nvim",
    build = ":TSUpdate html",
    cmd = { "Leet", "LeetCode" },
    dependencies = {
      "nvim-telescope/telescope.nvim",
      "nvim-lua/plenary.nvim", -- required by telescope
      "MunifTanjim/nui.nvim",

      -- optional
      "nvim-treesitter/nvim-treesitter",
      "rcarriga/nvim-notify",
      "nvim-tree/nvim-web-devicons",
    },
    config = function()
      require("leetcode").setup {
        -- LeetCode domain (default: "com")
        domain = "com", -- For "leetcode.com", use "cn" for "leetcode.cn"

        -- Programming language for problems
        lang = "golang", -- or "cpp", "java", "javascript", etc.

        -- Storage directory for problems
        storage = {
          home = "/Users/jn/leetcode-solutions",
          cache = vim.fn.stdpath "cache" .. "/leetcode",
        },
      }
    end,
  },
  {
    "stevearc/conform.nvim",
    event = "BufWritePre",
    opts = require "configs.conform",
  },

  -- nvim-lspconfig is configured in lua/plugins/lsp.lua
  -- (removed duplicate to prevent conflicts)
  -- nvim-cmp is configured in lua/plugins/cmp_cmdline.lua (same file that handles command completion)

  -- test new blink
  -- { import = "nvchad.blink.lazyspec" },

  -- {
  -- 	"nvim-treesitter/nvim-treesitter",
  -- 	opts = {
  -- 		ensure_installed = {
  -- 			"vim", "lua", "vimdoc",
  --      "html", "css"
  -- 		},
  -- 	},
  -- },
  {
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts)
      opts = opts or {}
      local ensure = opts.ensure_installed or {}
      local to_add = { "go", "gomod", "gotmpl", "html", "css", "python" }
      local present = {}
      for _, name in ipairs(ensure) do
        present[name] = true
      end
      for _, name in ipairs(to_add) do
        if not present[name] then
          table.insert(ensure, name)
        end
      end
      opts.ensure_installed = ensure
      opts.highlight = opts.highlight or {}
      opts.highlight.enable = true
      return opts
    end,
  },
  {
    "windwp/nvim-ts-autotag",
    ft = { "html", "xml", "javascript", "typescript", "tsx", "vue", "svelte", "gotmpl", "gohtmltmpl" },
    opts = {},
    config = function()
      require("nvim-ts-autotag").setup()
    end,
  },
  {
    "kdheepak/lazygit.nvim",
    cmd = "LazyGit",
    dependencies = { "nvim-lua/plenary.nvim" },
  },
  {
    "folke/noice.nvim",
    event = "VeryLazy",
    dependencies = {
      "MunifTanjim/nui.nvim",
      "rcarriga/nvim-notify",
    },
    opts = {},
  },
  {
    "lukas-reineke/indent-blankline.nvim",
    event = "VeryLazy",
    main = "ibl",
    opts = {
      indent = {
        char = "│",
        tab_char = "│",
        highlight = "IblIndent",
      },
      scope = {
        enabled = true,
        char = "│",
        show_start = false,
        show_end = false,
        highlight = "IblScope",
      },
      exclude = {
        filetypes = {
          "help",
          "alpha",
          "dashboard",
          "neo-tree",
          "Trouble",
          "trouble",
          "lazy",
          "mason",
          "notify",
          "toggleterm",
          "lazyterm",
        },
      },
    },
  },
}
