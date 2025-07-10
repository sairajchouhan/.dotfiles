-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

-- vim.keymap.set("n", "[f", "<cmd>bprevious<cr>", { desc = "Prev Buffer", remap = true })
-- vim.keymap.set("n", "]f", "<cmd>bnext<cr>", { desc = "Next Buffer", remap = true })
vim.keymap.set({ "n", "v" }, "F", function()
  LazyVim.format({ force = true })
end)

-- https://www.lazyvim.org/keymaps#bufferlinenvim
