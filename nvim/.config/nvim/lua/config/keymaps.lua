local opts = { noremap = true, silent = true }
local keymap = vim.api.nvim_set_keymap

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

keymap('n', '<leader>co', '<cmd>BufferLineCloseOthers<cr>', opts)
keymap('n', '<Tab>', '<cmd>BufferLineCyclePrev<cr>', opts)
keymap('n', '<S-Tab>', '<cmd>BufferLineCycleNext<cr>', opts)

keymap(
  'n',
  '<leader>sf',
  ':source %<CR>',
  vim.tbl_extend('force', opts, {
    callback = function()
      vim.cmd ':lua print("sourced current file")'
    end,
  })
)
