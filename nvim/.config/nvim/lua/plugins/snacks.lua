return {
  'folke/snacks.nvim',
  priority = 1000,
  lazy = false,
  keys = {
    -- {
    --   '<leader>cR',
    --   function()
    --     Snacks.rename.rename_file()
    --   end,
    --   desc = 'Rename File',
    -- },
  },
  opts = {
    bigfile = { enabled = true },
  },
}
