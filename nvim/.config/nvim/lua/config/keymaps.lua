-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

local opts = { noremap = true, silent = true }

vim.keymap.set({ "n", "v" }, "F", function()
  LazyVim.format({ force = true })
end)

vim.keymap.set("n", ";d", function()
  vim.diagnostic.open_float({
    scope = "line",
  })
end, { desc = "Show line diagnostics" })

vim.keymap.set("n", "<cr>", "<cmd>noh<cr><cr>", opts)

vim.keymap.set("n", "<C-S-Up>", "<cmd>resize +2<cr>", { desc = "Increase Window Height" })
vim.keymap.set("n", "<C-S-Down>", "<cmd>resize -2<cr>", { desc = "Decrease Window Height" })
vim.keymap.set("n", "<C-S-Left>", "<cmd>vertical resize -2<cr>", { desc = "Decrease Window Width" })
vim.keymap.set("n", "<C-S-Right>", "<cmd>vertical resize +2<cr>", { desc = "Increase Window Width" })

-- https://www.lazyvim.org/keymaps#bufferlinenvim
