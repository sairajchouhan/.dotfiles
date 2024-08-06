vim.api.nvim_create_autocmd("TextYankPost", {
	desc = "Highlight when yanking text",
	group = vim.api.nvim_create_augroup("highlight_yank", { clear = true }),
	callback = function()
		vim.highlight.on_yank({
			timeout = 30,
		})
	end,
})

vim.api.nvim_create_autocmd("BufWinEnter", {
	desc = "Open help on right side split",
	group = vim.api.nvim_create_augroup("help_window_right", {}),
	pattern = { "*.txt" },
	callback = function()
		if vim.o.filetype == "help" then
			vim.cmd.wincmd("L")
		end
	end,
})

----------------------------------
local function get_keys(tbl)
	local keys = {}
	for key, _ in pairs(tbl) do
		table.insert(keys, key)
	end
	return keys
end

local function starts_with(str, prefix)
    return string.sub(str, 1, string.len(prefix)) == prefix
end

local main_commands = { "relative_line_numbers", "something" }
local args = { relative_line_numbers = { "toggle", "on", "off" }, something = { "a", "b" } }
local args_keys = get_keys(args)

-- this is the aim
-- :Customise relative_line_numbers toggle
vim.api.nvim_create_user_command("Customise", function(opts)
  P(starts_with(opts.fargs[1], "relative_line_numbers"))
	if opts.fargs[1] == "relative_line_numbers" then
		P("hello hello i am thope")
	end
	P(opts)
end, {
	nargs = 1,
	complete = function()
		return args_keys
	end,
})
