require('mason').setup()
require('mason-lspconfig').setup()

vim.diagnostic.config({
	severity_sort = true,
	update_in_insert = true,
	float = { source = 'if_many' },
	jump = { float = true },
})
