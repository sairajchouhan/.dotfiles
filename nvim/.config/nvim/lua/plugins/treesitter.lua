return {
  "nvim-treesitter/nvim-treesitter",
  opts = {
    textobjects = {
      move = {
        -- this was done to eable [f and ]f keymaps to move between buffers
        enable = false,
      },
    },
  },
}
