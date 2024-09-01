local opts = { noremap = true, silent = true }
local opts_f = function(more_opts)
  return vim.tbl_deep_extend('force', opts, more_opts)
end
local keymap = vim.keymap.set

keymap('i', '<C-c>', '<ESC>', opts)
keymap('n', '<C-c>', '<ESC>', opts)
keymap('n', '<cr>', '<cmd>noh<cr><cr>', opts)

-- resize windows
keymap('n', '<C-S-Up>', ':resize +2<CR>', opts)
keymap('n', '<C-S-Down>', ':resize -2<CR>', opts)
keymap('n', '<C-S-Left>', ':vertical resize +2<CR>', opts)
keymap('n', '<C-S-Right>', ':vertical resize -2<CR>', opts)

-- move lines up and down
keymap('v', 'J', ":m '>+1<CR>gv=gv", opts)
keymap('v', 'K', ":m '<-2<CR>gv=gv", opts)

-- search terms stay in middle of screen
keymap('n', 'n', 'nzzzv', opts)
keymap('n', 'N', 'Nzzzv', opts)

keymap('n', 'x', '"_x', opts) -- do not yank on x
keymap('v', 'p', '"_dP', opts) -- do not update the register on paste

-- keymap('n', '<leader>co', '<cmd>BufferLineCloseOthers<cr>', opts)
keymap('n', '<Tab>', '<cmd>BufferLineCyclePrev<cr>', opts)
keymap('n', '<S-Tab>', '<cmd>BufferLineCycleNext<cr>', opts)

-- for quickfix list
keymap('n', '<leader>cn', ':cnext<CR>', opts_f { desc = 'Next item in quickfix list'})
keymap('n', '<leader>cp', ':cprevious<CR>', opts_f { desc = 'Previous item in quickfix list' })
keymap('n', '<leader>co', ':copen<CR>', opts_f { desc = 'Open quickfix list' })
keymap('n', '<leader>cc', ':cclose<CR>', opts_f { desc = 'Close quickfix list' })

keymap(
  'n',
  '<leader>so',
  ':source %<CR>',
  vim.tbl_extend('force', opts, {
    callback = function()
      vim.cmd ':lua print("sourced current file")'
    end,
  })
)
