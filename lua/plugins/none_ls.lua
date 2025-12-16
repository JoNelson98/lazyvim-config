return {
  {
    "nvimtools/none-ls.nvim",
    dependencies = {
      "nvimtools/none-ls-extras.nvim",
      "jayp0521/mason-null-ls.nvim",
    },
    config = function()
      require("mason-null-ls").setup({
        ensure_installed = {
          "ruff",
          "prettier",
        },
        automatic_installation = true,
      })

      local null_ls = require("null-ls")

      local augroup = vim.api.nvim_create_augroup("LspFormatting", {})

      null_ls.setup({
        sources = {
          -- 🗣️ THE YELLING (diagnostics)
          -- require("none-ls.diagnostics.ruff"),
          --
          -- ✨ THE FORMATTING (python)
          -- require("none-ls.formatting.ruff_format"),

          -- ✨ NON-PYTHON
          null_ls.builtins.formatting.prettier.with({
            filetypes = { "json", "yaml", "markdown" },
          }),
        },

        on_attach = function(client, bufnr)
          if client.supports_method("textDocument/formatting") then
            vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
            vim.api.nvim_create_autocmd("BufWritePre", {
              group = augroup,
              buffer = bufnr,
              callback = function()
                vim.lsp.buf.format({
                  async = false,
                  filter = function(c)
                    return c.name == "null-ls"
                  end,
                })
              end,
            })
          end
        end,
      })
    end,
  },
}
