vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

vim.o.relativenumber = true
vim.o.number = true

vim.o.ignorecase = true
vim.o.smartcase = true

vim.schedule(function() vim.o.clipboard = 'unnamedplus' end)
vim.o.confirm = true

vim.o.ttimeoutlen = 1
vim.o.swapfile = false
vim.o.signcolumn = 'yes' -- make lsp warnings not widen the gutter
vim.o.winborder = "rounded"
