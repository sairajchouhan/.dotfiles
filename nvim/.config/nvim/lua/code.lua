local M = {}

local keymap = vim.keymap.set
local vscode = require("vscode")

vim.api.nvim_set_hl(0, "YankHighlight", { bg = "#e0af68", fg = "NONE" })

vim.api.nvim_create_autocmd("TextYankPost", {
  desc = "Highlight when yanking text",
  group = vim.api.nvim_create_augroup("highlight_yank", { clear = true }),
  callback = function()
    vim.highlight.on_yank({
      timeout = 30,
      higroup = "YankHighlight",
    })
  end,
})

vim.g.mapleader = " "
vim.g.maplocalleader = " "
vim.opt.clipboard = "unnamedplus"

local opts = { noremap = true, silent = true }

keymap("n", "<cr>", "<cmd>noh<cr><cr>", opts)
keymap("n", "x", '"_x', opts) -- do not yank on x
keymap("v", "p", '"_dP', opts) -- do not update the register on paste
keymap("i", "<C-c>", "<ESC>", opts)
keymap("n", "<C-c>", "<ESC>", opts)

vim.keymap.set("n", "gr", function()
  vscode.action("editor.action.referenceSearch.trigger")
end)

vim.keymap.set("n", "<leader>rn", function()
  vscode.action("editor.action.rename")
end)

vim.keymap.set("n", "<leader>ca", function()
  vscode.action("editor.action.quickFix")
end)

vim.keymap.set("n", "[c", function()
  vscode.action("workbench.action.editor.previousChange")
end)

vim.keymap.set("n", "]c", function()
  vscode.action("workbench.action.editor.nextChange")
end)

vim.keymap.set("n", "[d", function()
  vscode.action("editor.action.marker.prev")
end)

vim.keymap.set("n", "]d", function()
  vscode.action("editor.action.marker.next")
end)

-- show current line error
vim.keymap.set("n", ";d", function()
  -- vim.cmd.normal { '0', bang = true }
  -- vscode.action 'editor.action.marker.next'
  vscode.action("editor.action.marker.next")
end)

vim.keymap.set("n", "[e", function()
  vscode.action("go-to-next-error.prev.error")
end)

vim.keymap.set("n", "]e", function()
  vscode.action("go-to-next-error.next.error")
end)

vim.keymap.set("n", "F", function()
  vscode.action("editor.action.formatDocument")
end)

vim.keymap.set("n", "<leader>co", function()
  vscode.action("workbench.action.closeOtherEditors")
end)

vim.keymap.set("n", "<S-h>", function()
  vscode.action("workbench.action.previousEditorInGroup")
end)

vim.keymap.set("n", "<S-l>", function()
  vscode.action("workbench.action.nextEditorInGroup")
end)

vim.keymap.set("n", "<leader>ff", function()
  vscode.action("workbench.action.quickOpen")
end)

vim.keymap.set("n", "<leader>fg", function()
  vscode.action("workbench.view.search")
end)

vim.keymap.set("n", "<leader>e", function()
  vscode.action("workbench.action.toggleSidebarVisibility")
end)

vim.keymap.set("n", "<leader>fR", function()
  vscode.action("copyRelativeFilePath")
end)

return M
