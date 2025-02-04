return {
  'folke/snacks.nvim',
  priority = 1000,
  lazy = false,
  opts = {
    bigfile = { enabled = true },
    indent = {
      enabled = true,
      animate = { enabled = false },
      char = '│',
      -- scope = { enabled = false },
    },
    dashboard = {
      enabled = true,
    },
    gitbrowse = {
      enabled = true,
    },
    git = {
      enabled = true,
    },
  },
  keys = {
    {
      '<leader>gB',
      function()
        Snacks.gitbrowse()
      end,
      desc = 'Git Browse',
      mode = { 'n', 'v' },
    },
  },
}

--   keys = {
--   -- {
--   --   '<leader>cR',
--   --   function()
--   --     Snacks.rename.rename_file()
--   --   end,
--   --   desc = 'Rename File',
--   -- },
-- },
--
