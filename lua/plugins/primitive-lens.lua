return {
  {
    dir = vim.fn.expand("~/documents/MY_PRODUCTS/primitive-lens"),
    name = "primitive-lens",
    lazy = false,
    priority = 1000,
    config = function()
      vim.g.primelens_bin = vim.fn.expand("~/documents/MY_PRODUCTS/primitive-lens/bin/primelensd")
    end,
  },
}
