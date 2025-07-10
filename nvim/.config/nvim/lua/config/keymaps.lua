-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

local opts = { noremap = true, silent = true }

vim.keymap.set({ "n", "v" }, "F", function()
  LazyVim.format({ force = true })
end)

vim.keymap.set("n", "<cr>", "<cmd>noh<cr><cr>", opts)

-- https://www.lazyvim.org/keymaps#bufferlinenvim
