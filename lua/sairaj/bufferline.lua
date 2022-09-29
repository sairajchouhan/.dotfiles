local status, bufferline = pcall(require, "bufferline")
if (not status) then 
  return 
end

bufferline.setup{
  options = {
    diagnostics = "nvim_lsp"
  }
}

vim.keymap.set('n', '<Tab>', '<Cmd>BufferLineCycleNext<CR>', {})
vim.keymap.set('n', '<S-Tab>', '<Cmd>BufferLineCyclePrev<CR>', {})

