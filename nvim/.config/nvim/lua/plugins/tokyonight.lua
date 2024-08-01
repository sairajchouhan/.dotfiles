return {
  'folke/tokyonight.nvim',
  lazy = false,
  priority = 1000,
  opts = {
    transparent = true,
    style = 'night',
    styles = {
      sidebars = 'transparent',
      floats = 'transparent'
    },
  },
  init = function()
    vim.cmd.colorscheme 'tokyonight-night'
  end,
}
