return {
  "alexghergh/nvim-tmux-navigation",
  event = "VeryLazy",
  config = true,
  opts = {
    disable_when_zoomed = true,
  },
  keys = {
    -- Disable LazyVim's default keymaps for C-h, C-j, C-k, C-l
    { "<C-h>", false },
    { "<C-j>", false },
    { "<C-k>", false },
    { "<C-l>", false },

    -- Map the keys for nvim-tmux-navigation
    { "<C-h>", "<Cmd>NvimTmuxNavigateLeft<CR>", desc = "Tmux navigate left" },
    { "<C-j>", "<Cmd>NvimTmuxNavigateDown<CR>", desc = "Tmux navigate down" },
    { "<C-k>", "<Cmd>NvimTmuxNavigateUp<CR>", desc = "Tmux navigate up" },
    { "<C-l>", "<Cmd>NvimTmuxNavigateRight<CR>", desc = "Tmux navigate right" },
  },
}
