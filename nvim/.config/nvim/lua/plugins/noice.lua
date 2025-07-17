return {
  "folke/noice.nvim",
  event = "VeryLazy",
  opts = {
    messages = {
      enabled = false,
    },
    presets = {
      lsp_doc_border = true, -- add a border to hover docs and signature help
    },
  },
}
