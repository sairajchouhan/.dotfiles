vim.api.nvim_set_hl(0, 'YankHighlight', { bg = '#e0af68', fg = 'NONE' })

vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking text',
  group = vim.api.nvim_create_augroup('highlight_yank', { clear = true }),
  callback = function()
    vim.highlight.on_yank {
      timeout = 30,
      higroup = 'YankHighlight',
    }
  end,
})

vim.g.mapleader = ' '
vim.g.maplocalleader = ' '
vim.opt.clipboard = 'unnamedplus'

return {}
