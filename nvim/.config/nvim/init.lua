if vim.g.vscode then
	require("code")
	return
end



require("options")
require("keymaps")
require("plugins.fff")

-- Vim diagnostics
vim.diagnostic.config({
	severity_sort = true,    -- show most severe error first
	update_in_insert = true, -- don't update while typing
	float = { source = 'if_many' }, -- nicer look for floats and show source if multiple sources (ex. ruff and ty)
	jump = { float = true }, -- automatically open the diagnostic float if you jump with [d ]d
})

require('vim._core.ui2').enable({})


-- Highlight yanks
vim.api.nvim_create_autocmd("TextYankPost", {
	desc = "Highlight when yanking text",
	group = vim.api.nvim_create_augroup("highlight_yank", { clear = true }),
	callback = function()
		vim.highlight.on_yank({
			timeout = 30,
		})
	end,
})

-- Plugins
-- Pack guide: https://echasnovski.com/blog/2026-03-13-a-guide-to-vim-pack#update
vim.pack.add({
	'https://github.com/nvim-treesitter/nvim-treesitter', -- also $ brew install tree-sitter-cli
	'https://github.com/neovim/nvim-lspconfig',
	'https://github.com/karb94/neoscroll.nvim',
	'https://github.com/stevearc/oil.nvim',
	'https://github.com/esmuellernt/codediff.nvim',
	'https://github.com/MeanderingProgrammer/render-markdown.nvim',
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

require('kanagawa').setup({
	colors = {
		theme = {
			all = {
				ui = {
					bg_gutter = "none"
				}
			}
		}
	}
})
vim.cmd('colorscheme kanagawa-wave') -- need to call after setup


-- Markdown
require('render-markdown').setup({})

-- Treesitter
vim.cmd('syntax off') -- Make it obvious if treesitter is missing
vim.api.nvim_create_autocmd('FileType', {
	callback = function() pcall(vim.treesitter.start) end,
})

-- LSP
vim.lsp.enable({
	'ty', -- also $ uv tool install ty@latest
	'ruff', -- also $ uv tool install ruff@latest
	'lua_ls', -- also $ brew install lua-language-server
	'ts_ls'
})

-- Auto-format ("lint") on save (adapted from neovim docs :help auto-format)
-- vim.api.nvim_create_autocmd('LspAttach', {
-- 	group = vim.api.nvim_create_augroup('my.lsp', { clear = true }),
-- 	callback = function(ev)
-- 		local client = assert(vim.lsp.get_client_by_id(ev.data.client_id))
-- 		if not client:supports_method('textDocument/willSaveWaitUntil')
-- 		    and client:supports_method('textDocument/formatting') then
-- 			vim.api.nvim_create_autocmd('BufWritePre', {
-- 				group = vim.api.nvim_create_augroup('my.lsp.fmt', { clear = false }),
-- 				buffer = ev.buf,
-- 				callback = function()
-- 					vim.lsp.buf.format({ bufnr = ev.buf, id = client.id, timeout_ms = 1000 })
-- 				end,
-- 			})
-- 		end
-- 	end,
-- })

-- Blink.cmp
require('blink.cmp').setup({
	keymap = {
		preset = "enter"
	}
})

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
vim.keymap.set("n", "<leader>e", "<CMD>Oil<CR>", { desc = "Open parent directory" })

require("codediff").setup({})

-- Toggleterm
require("toggleterm").setup({
	open_mapping = [[<c-\>]],
	direction = "float",
	shell = vim.fn.executable("fish") == 1 and "fish" or vim.o.shell,
})
