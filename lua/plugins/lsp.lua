return {
  {
    "williamboman/mason-lspconfig.nvim",
    opts = {
      ensure_installed = {}, -- DO NOT put pylsp here - install via pipx instead
    },
  },
  {
    "neovim/nvim-lspconfig",
    event = { "BufReadPre", "BufNewFile" },
    config = function()
      -- Load NvChad defaults first
      require("nvchad.configs.lspconfig").defaults()

      -- Then configure pylsp manually
      local lspconfig = require("lspconfig")
      local caps = require("cmp_nvim_lsp").default_capabilities()

      -- Ensure formatting capability is enabled
      caps.textDocument.documentFormattingProvider = true

      lspconfig.pylsp.setup({
        cmd = { vim.fn.expand("~/.local/bin/pylsp") },
        capabilities = caps,
        settings = {
          pylsp = {
            plugins = {
              pyflakes = { enabled = false },
              pycodestyle = { enabled = false },
              mccabe = { enabled = false },
              pylint = { enabled = false },

              jedi_completion = { enabled = true },
              jedi_hover = { enabled = true },
              jedi_definition = { enabled = true },
              jedi_references = { enabled = true },
              jedi_signature_help = { enabled = true },

              autopep8 = { enabled = true },
            },
          },
        },
        on_attach = function(client, bufnr)
          -- Format on save for Python files (using pylsp's autopep8)
          if client.supports_method("textDocument/formatting") then
            local augroup = vim.api.nvim_create_augroup("LspFormatting", { clear = true })
            vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
            vim.api.nvim_create_autocmd("BufWritePre", {
              group = augroup,
              buffer = bufnr,
              callback = function()
                vim.lsp.buf.format({
                  async = false,
                  filter = function(c)
                    return c.name == "pylsp"
                  end
                })
              end,
            })
          end

          -- Manual format keybinding: <leader>fm
          vim.keymap.set("n", "<leader>fm", function()
            vim.lsp.buf.format({
              async = false,
              filter = function(c)
                return c.name == "pylsp"
              end
            })
          end, { buffer = bufnr, desc = "Format with pylsp (autopep8)" })
        end,
      })
    end,
  },
}
