require('sairaj.plugins') 
require('sairaj.completions')
require('sairaj.lsp')
require('sairaj.treesitter')
require('sairaj.telescope')
require('sairaj.autopairs')
require('sairaj.autotags')
require('sairaj.comment')
require('sairaj.gitsigns')
require('sairaj.keymaps')
require('sairaj.nvim-tree')
require('sairaj.lualine')
require('sairaj.colorschemes')
require('sairaj.toggleterm')
require('sairaj.lspsaga')
-- require('sairaj.null-ls')
-- require("sairaj.bufferline")
-- require("sairaj.prettier")



local g = vim.g
local o = vim.opt
local a = vim.api


-- kinda global
g.loaded = 1
g.loaded_netrwPlugin = 1


-- options
--[[ o.ls = 0 ]]
o.ch = 0
o.relativenumber = true
o.cursorline = true
o.tabstop = 2
o.shiftwidth = 2
o.expandtab = true
o.smarttab = true
o.mouse = "a"
o.fileencoding = 'utf-8'
o.swapfile = false
-- o.timeoutlen = 200
o.termguicolors = true
o.numberwidth = 4
o.ignorecase = true
o.smartcase = true
o.signcolumn = "yes"
o.smartindent = true


a.nvim_create_autocmd('TextYankPost', {
    group = num_au,
    callback = function()
        vim.highlight.on_yank({ higroup = 'Visual', timeout = 50 })
    end,
})

