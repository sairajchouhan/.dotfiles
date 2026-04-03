if vim.g.vscode then
	require("code")
	return
end

-- bootstrap lazy.nvim, LazyVim and your plugins
require("config.lazy")
