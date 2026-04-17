-- Show diagnostics
vim.keymap.set('n', ';d', vim.diagnostic.open_float, { desc = 'Show diagnostics' })

-- Restart Neovim
vim.keymap.set('n', '<leader>re', '<cmd>restart<cr>', { desc = 'Restart Neovim' })

-- Quit all
vim.keymap.set('n', '<leader>qq', '<cmd>qa<cr>', { desc = 'Quit All' })

-- Easily move between windows
vim.keymap.set('n', '<C-h>', '<C-w><C-h>', { desc = 'Move focus to the left window' })
vim.keymap.set('n', '<C-l>', '<C-w><C-l>', { desc = 'Move focus to the right window' })
vim.keymap.set('n', '<C-j>', '<C-w><C-j>', { desc = 'Move focus to the lower window' })
vim.keymap.set('n', '<C-k>', '<C-w><C-k>', { desc = 'Move focus to the upper window' })

vim.keymap.set('n', 'gd', vim.lsp.buf.definition, { desc = 'Go to definition' })

vim.keymap.set({ 'n', 'v' }, 'F', function()
	vim.lsp.buf.format({ async = true })
end, { desc = 'Format buffer' })

vim.keymap.set('n', '<cr>', '<cmd>noh<cr><cr>', { desc = 'Clear search highlight' })

-- Oil
vim.keymap.set('n', '<leader>e', '<CMD>Oil<CR>', { desc = 'Open parent directory' })

-- fff.nvim
vim.keymap.set('n', '<leader>ff', function()
	require('fff').find_files()
end, { desc = 'FFFind files' })

vim.keymap.set('n', '<leader>fg', function()
	require('fff').live_grep({
		grep = {
			modes = { 'plain', 'regex', 'fuzzy' },
		},
	})
end, { desc = 'FFLive grep' })
