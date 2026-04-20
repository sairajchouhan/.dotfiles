require('blink.cmp').setup({
	keymap = {
		preset = "enter"
	},
	appearance = {
		nerd_font_variant = 'mono',
	},
	completion = {
		menu = {
			border = 'rounded',
			max_height = 10,
			draw = {
				padding = 1,
				gap = 1,
				columns = {
					{ 'label', 'label_description', gap = 1 },
					{ 'kind' },
				},
			},
			winhighlight = 'Normal:NormalFloat,FloatBorder:FloatBorder,CursorLine:PmenuSel,Search:None,BlinkCmpScrollBarGutter:NormalFloat,BlinkCmpScrollBarThumb:FloatBorder',
		},
		documentation = {
			window = { border = 'rounded' },
		},
	},
})
