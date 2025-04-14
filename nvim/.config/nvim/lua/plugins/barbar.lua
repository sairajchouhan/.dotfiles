return {
  'romgrk/barbar.nvim',
  enabled = false,
  dependencies = {
    'lewis6991/gitsigns.nvim', -- OPTIONAL: for git status
    'nvim-tree/nvim-web-devicons', -- OPTIONAL: for file icons
  },
  init = function()
    vim.g.barbar_auto_setup = false
  end,
  opts = {
    sidebar_filetypes = {
      ['neo-tree'] = { event = 'BufWipeout' },
    },
    icons = {
      pinned = { button = '', filename = true },
      filetype = { enabled = false },
    },
  },
  version = '^1.9.0',
}

--
-- return {
--   'romgrk/barbar.nvim',
--   enabled = true,
--   init = function()
--     vim.g.barbar_auto_setup = false
--   end,
--   config = function()
--     local barbar = require 'barbar'
--
--     barbar.setup {
--       sidebar_filetypes = {
--         ['neo-tree'] = { event = 'BufWipeout' },
--       },
--       icons = {
--         pinned = { button = '', filename = true },
--         filetype = { enabled = false },
--       },
--     }
--   end,
--   version = '^1.9.0',
-- }
