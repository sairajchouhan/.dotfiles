return {
	"nvim-telescope/telescope.nvim",
	tag = "0.1.8",
	event = "VimEnter",
	dependencies = {
		"nvim-lua/plenary.nvim",
		{
			"nvim-telescope/telescope-fzf-native.nvim",
			build = "make",
			cond = function()
				return vim.fn.executable("make") == 1
			end,
		},
	},
	config = function()
		local builtin = require("telescope.builtin")

		require("telescope").setup({
			defaults = {
				sorting_strategy = "ascending",
				layout_config = {
					prompt_position = "top",
				},
				-- always ignore .git folders
				file_ignore_patterns = { "%.git/" }
			},
			pickers = {
				live_grep = {
					layout_config = {
						preview_width = 0.5,
					},
				},
				find_files = {
					hidden = true
				},
				lsp_references = {
					-- removes inline lsp preview
					show_line = false,
					layout_config = {
						preview_width = 0.6
					}
				}
			},
			extensions = {},
		})

		pcall(require("telescope").load_extension, "fzf")

		vim.keymap.set("n", "<leader>ff", builtin.find_files, { desc = "Find files" })
		vim.keymap.set("n", "<leader>fg", builtin.live_grep, { desc = "Search by grep" })
		vim.keymap.set("n", "<leader>fh", builtin.help_tags, { desc = "Search help"})
		vim.keymap.set("n", "<leader>fw", builtin.grep_string, { desc = "Search current word" })
		vim.keymap.set("n", "<leader>fk", builtin.keymaps, { desc = "Search keymaps" })
	end,
}
