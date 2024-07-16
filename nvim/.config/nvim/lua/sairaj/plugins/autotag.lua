return {
  'windwp/nvim-ts-autotag',
  config = function()
    require('nvim-ts-autotag').setup({ did_setup = true })
  end,
}
