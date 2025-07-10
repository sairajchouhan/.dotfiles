return {
  "neovim/nvim-lspconfig",
  opts = {
    diagnostics = {
      signs = {
        [vim.diagnostic.severity.ERROR] = "E",
        [vim.diagnostic.severity.WARN] = "W",
        [vim.diagnostic.severity.HINT] = "H",
        [vim.diagnostic.severity.INFO] = "I",
      },
    },
  },
}
