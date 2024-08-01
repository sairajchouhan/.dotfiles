vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking text',
  group = vim.api.nvim_create_augroup('highlight-yank', { clear = true }),
  callback = function()
    vim.highlight.on_yank {
      timeout = 30,
    }
  end,
})

-- currently line numbers are shown after entering nvim
-- vim.api.nvim_create_autocmd('VimEnter', {
--   desc = 'Open file tree on vim enter',
--   group = vim.api.nvim_create_augroup('neo-tree-open', { clear = true }),
--   callback = function()
--     vim.cmd("Neotree toggle") 
--   end,
-- })
