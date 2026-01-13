-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua

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
vim.keymap.set("n", "x", '"_x', opts) -- do not yank on x
vim.keymap.set("v", "p", '"_dP', opts) -- do not update the register on paste
