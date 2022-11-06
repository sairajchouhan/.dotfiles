local opts = { noremap = true, silent = true }
local keymap = vim.api.nvim_set_keymap


keymap("n", "<Space>", "", opts)
vim.g.mapleader = " "
vim.g.maplocalleader = " "

keymap('i', 'jj', '<ESC>', opts)
keymap('n', '<leader>e', ':NvimTreeToggle<CR>', opts)
keymap('n', '<leader>w', ':w<CR>', opts)

keymap('n', 'x', '"_x', opts) -- do not yank on x
keymap('v', 'p', '"_dP', opts) -- do not update the register on paste
keymap('n', '<cr>' , '<cmd>noh<cr><cr>', opts) -- remove the serach highlight 


-- navigating between splits
keymap('n', "<C-h>", "<C-w>h", opts)
keymap('n', "<C-j>", "<C-w>j", opts)
keymap('n', "<C-k>", "<C-w>k", opts)
keymap('n', "<C-l>", "<C-w>l", opts)

-- resize windows
keymap("n", "<C-S-Up>", ":resize -2<CR>", opts)
keymap("n", "<C-S-Down>", ":resize +2<CR>", opts)
keymap("n", "<C-S-Left>", ":vertical resize -2<CR>", opts)
keymap("n", "<C-S-Right>", ":vertical resize +2<CR>", opts)

-- telescope
keymap('n', "<leader>ff", "<cmd>lua require('telescope.builtin').find_files()<cr>", opts)
keymap('n', "<leader>fg", "<cmd>lua require('telescope.builtin').live_grep()<cr>", opts)
keymap('n', "<leader>fb", "<cmd>lua require('telescope.builtin').buffers()<cr>", opts)
keymap('n', "<leader>fh", "<cmd>lua require('telescope.builtin').help_tags()<cr>", opts)
keymap('n', "<leader>dl", "<cmd>lua require('telescope.builtin').diagnostics()<cr>", opts)


-- opens a lazygit popup
keymap('n', '<leader>lg', "<cmd>lua _LAZYGIT_TOGGLE()<cr>", opts)



-- buffer line
--[[ keymap('n', '<leader>c', "<cmd>BufferLineCloseLeft<cr> <cmd>BufferLineCloseRight<cr>", opts) ]]
keymap('n', '<Tab>', '<Cmd>BufferLineCycleNext<CR>', opts)
keymap('n', '<S-Tab>', '<Cmd>BufferLineCyclePrev<CR>', opts)


-- lsp format
keymap('n', '<S-f>', '<Cmd>lua vim.lsp.buf.format()<CR> <Cmd>w<CR>', opts)
