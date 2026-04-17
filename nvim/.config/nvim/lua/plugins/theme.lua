require('kanagawa').setup({
	colors = {
		theme = {
			all = {
				ui = {
					bg_gutter = "none"
				}
			}
		}
	},
	overrides = function(colors)
		local theme = colors.theme
		return {
			NormalFloat = { bg = theme.ui.bg },
			FloatBorder = { bg = theme.ui.bg },
			FloatTitle  = { bg = theme.ui.bg },
		}
	end,
})

vim.cmd('colorscheme kanagawa-wave')
