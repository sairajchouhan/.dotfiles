local opts = { noremap = true, silent = true }
local keymap = vim.api.nvim_set_keymap


keymap("n", "<Space>", "", opts)
vim.g.mapleader = " "
vim.g.maplocalleader = " "

keymap('i', 'jj', '<ESC>', { noremap = true })
keymap('n', '<leader>e', ':NvimTreeToggle<CR>', { noremap = true })
keymap('n', '<leader>w', ':w<CR>', { noremap = true })

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
