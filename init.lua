local g = vim.g
local o = vim.opt
local a = vim.api

o.termguicolors = true

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
require('sairaj.null-ls')
require("sairaj.mason")
require("sairaj.colorizer")
require("sairaj.bufferline")





-- kinda global
g.loaded = 1
g.loaded_netrwPlugin = 1


-- options
--[[ o.ls = 1 ]]
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


local has = function(x)
  return vim.fn.has(x) == 1
end


local is_mac = has "macunix"
local is_windows = has "win32" 


if is_mac then
  vim.opt.clipboard:append { 'unnamedplus' }
end

if is_windows then
  vim.opt.clipboard:prepend { 'unnamed', 'unnamedplus' }
end


-- this is required for deno lsp to work for some reason
vim.g.markdown_fenced_languages = {
  "ts=typescript"
}
