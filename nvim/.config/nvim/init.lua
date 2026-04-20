if vim.g.vscode then
	require("code")
	return
end


require("options")
require("keymaps")
require("autocmds")
require("plugins.fff")

require('vim._core.ui2').enable({})

-- Plugins
-- Pack guide: https://echasnovski.com/blog/2026-03-13-a-guide-to-vim-pack#update
vim.pack.add({
	'https://github.com/nvim-treesitter/nvim-treesitter', -- also $ brew install tree-sitter-cli
	'https://github.com/neovim/nvim-lspconfig',
	'https://github.com/mason-org/mason.nvim',
	'https://github.com/mason-org/mason-lspconfig.nvim',
	'https://github.com/karb94/neoscroll.nvim',
	'https://github.com/stevearc/oil.nvim',
	'https://github.com/esmuellernt/codediff.nvim',
	{ src = 'https://github.com/saghen/blink.cmp', version = vim.version.range('1.x') },
	'https://github.com/nvim-mini/mini.pairs',
	'https://github.com/nvim-mini/mini.statusline',
	'https://github.com/nvim-mini/mini.tabline',
	'https://github.com/nvim-mini/mini.icons',
	'https://github.com/dmtrKovalenko/fff.nvim',
	'https://github.com/rebelot/kanagawa.nvim',
	'https://github.com/akinsho/toggleterm.nvim',
	'https://github.com/tpope/vim-sleuth'
})

require("mini.pairs").setup()
require("mini.statusline").setup()
require("mini.tabline").setup()
require("mini.icons").setup()

require("plugins.theme")

-- Treesitter
vim.cmd('syntax off') -- Make it obvious if treesitter is missing
vim.api.nvim_create_autocmd('FileType', {
	callback = function() pcall(vim.treesitter.start) end,
})
-- LSP
require("lsp")

require("completion")

-- Neoscroll
require('neoscroll').setup({
	hide_cursor = false,
	stop_eof = true,
	easing = 'quadratic',
	duration_multiplier = 0.30,
})

-- Oil.nvim
require("oil").setup({
	view_options = {
		show_hidden = true,
	},
})
require("codediff").setup({})

-- Toggleterm
require("toggleterm").setup({
	open_mapping = [[<c-\>]],
	direction = "float",
	shell = vim.fn.executable("fish") == 1 and "fish" or vim.o.shell,
})
