return {
  "akinsho/bufferline.nvim",
  version = "*",
  dependencies = 'nvim-tree/nvim-web-devicons',
  config = function ()
    require('bufferline').setup({})
    vim.api.nvim_set_keymap('n', '<leader>co', '<cmd>BufferLineCloseOthers<cr>', { noremap = true, silent = true })
    vim.api.nvim_set_keymap('n', '[b', '<cmd>BufferLineCyclePrev<cr>', { noremap = true, silent = true })
    vim.api.nvim_set_keymap('n', ']b', '<cmd>BufferLineCycleNext<cr>', { noremap = true, silent = true })
  end
}

