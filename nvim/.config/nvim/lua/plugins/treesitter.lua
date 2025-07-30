return {
  {

    "nvim-treesitter/nvim-treesitter",
    opts = {
      textobjects = {
        move = {
          -- this was done to eable [f and ]f keymaps to move between buffers
          enable = false,
        },
      },
    },
  },
  {
    "nvim-treesitter/nvim-treesitter-context",
    opts = {
      multiline_threshold = 4,
      max_lines = 4,
    },
  },
}
