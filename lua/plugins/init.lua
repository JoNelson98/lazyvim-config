return {
  -- Ensure required LSP servers are installed
  {
    "williamboman/mason-lspconfig.nvim",
    event = "VeryLazy",
    opts = function(_, opts)
      opts = opts or {}
      opts.ensure_installed = opts.ensure_installed or {}
      local to_add = { "ts_ls", "eslint", "jsonls", "html", "cssls" }
      local present = {}
      for _, name in ipairs(opts.ensure_installed) do
        present[name] = true
      end
      for _, name in ipairs(to_add) do
        if not present[name] then
          table.insert(opts.ensure_installed, name)
        end
      end
      return opts
    end,
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
    opts = {
      -- use default command name instead of boolean
      goimports = "goimports",
      lsp_cfg = true,
    },
    config = function(_, opts)
      require("go").setup(opts)
      vim.api.nvim_create_autocmd("BufWritePre", {
        pattern = "*.go",
        callback = function()
          require("go.format").goimports()
        end,
        group = vim.api.nvim_create_augroup("GoFormat", {}),
      })
    end,
  },
  {
    "nvim-tree/nvim-tree.lua",
    cmd = { "NvimTreeToggle", "NvimTreeFocus", "NvimTreeFindFile", "NvimTreeOpen", "NvimTreeClose" },
    opts = {
      on_attach = function(bufnr)
        local api = require "nvim-tree.api"
        local function opts(desc)
          return { desc = "nvim-tree: " .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
        end
        api.config.mappings.default_on_attach(bufnr)

        vim.keymap.set("n", "l", api.node.open.edit, opts "Open")
        vim.keymap.set("n", "h", api.node.navigate.parent_close, opts "Close")
      end,
    },
  },

  {
    -- grep visible on telescope
    "nvim-telescope/telescope.nvim",
    cmd = "Telescope",
    module = { "telescope", "telescope.builtin" },
    keys = {
      { "<leader>ff", function() require("telescope.builtin").find_files() end, desc = "Find files" },
      { "<leader>fg", function() require("telescope.builtin").live_grep() end,  desc = "Live grep" },
      { "<leader>fw", function() require("telescope.builtin").live_grep() end,  desc = "Live grep (words)" },
      { "<leader>fb", function() require("telescope.builtin").buffers() end,    desc = "Buffers" },
      { "<leader>fh", function() require("telescope.builtin").help_tags() end,  desc = "Help tags" },
    },
    opts = function(_, opts)
      local actions = require "telescope.actions"

      opts.defaults.layout_strategy = "flex"
      opts.defaults.layout_config = vim.tbl_deep_extend("force", opts.defaults.layout_config or {}, {
        preview_cutoff = 1,

        width = function(_, max_cols)
          return max_cols
        end,
        height = function(_, max_lines)
          return max_lines
        end,
      })
      -- NEW: custom keymaps
      opts.defaults.mappings = vim.tbl_deep_extend("force", opts.defaults.mappings or {}, {
        -- INSERT MODE mappings
        i = {
          ["<S-j>"] = actions.move_selection_next,
          ["<S-k>"] = actions.move_selection_previous,
        },
        -- NORMAL MODE mappings
        n = {
          ["J"] = actions.move_selection_next,
          ["K"] = actions.move_selection_previous,
        },
      })
      return opts
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
    event = 'BufWritePre',
    opts = require "configs.conform",
  },

  -- These are some examples, uncomment them if you want to see them work!
  {
    "neovim/nvim-lspconfig",
    event = { "BufReadPre", "BufNewFile" },
    config = function()
      require "configs.lspconfig"
    end,
  },
  {
    "hrsh7th/nvim-cmp",
    event = "InsertEnter",
    opts = function(_, opts)
      local cmp = require "cmp"
      -- kill off the default ctrl-j/k
      opts.mapping["<C-j>"] = nil
      opts.mapping["<C-k>"] = nil

      -- bind Alt (Option) + j/k for next/prev completion
      opts.mapping["<A-j>"] = cmp.mapping.select_next_item { behavior = cmp.SelectBehavior.Insert }

      opts.mapping["<A-k>"] = cmp.mapping.select_prev_item { behavior = cmp.SelectBehavior.Insert }
      return opts
    end,
  },

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
}
