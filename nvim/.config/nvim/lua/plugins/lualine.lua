return {
  'nvim-lualine/lualine.nvim',
  dependencies = { 'nvim-tree/nvim-web-devicons' },
  opts = {
    options = {
      theme = 'tokyonight',
      icons_enabled = false,
    },
    extensions = {
      'neo-tree',
      'mason',
      'lazy',
      'trouble',
    },
  },
}
