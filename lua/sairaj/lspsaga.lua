local status_ok, lspsaga = pcall(require, "lspsaga")

if not status_ok then
  return
end

local keymap = vim.keymap.set

local opts = { noremap = true, silent = true }

lspsaga.init_lsp_saga({
  border_style = "rounded",
  code_action_lightbulb = {
    virtual_text = false,
  },
})

keymap("n", "gh", "<cmd>Lspsaga lsp_finder<CR>", opts) -- preview definition, implementations, references

keymap({"n","v"}, "<leader>ca", "<cmd>Lspsaga code_action<CR>", opts) -- code action

keymap("n", "<leader>rn", "<cmd>Lspsaga rename<CR>", opts) -- lsp rename

keymap("n", "K", "<cmd>Lspsaga hover_doc<CR>", opts) -- hover doc

-- Show line diagnostics
keymap("n", ";d", "<cmd>Lspsaga show_line_diagnostics<CR>", opts)

-- Show cursor diagnostic
keymap("n", "<leader>cd", "<cmd>Lspsaga show_cursor_diagnostics<CR>", opts)

-- go to next and prev diagnostics
keymap("n", "[d", "<cmd>Lspsaga diagnostic_jump_prev<CR>zz", opts)
keymap("n", "]d", "<cmd>Lspsaga diagnostic_jump_next<CR>zz", opts)

-- only errors 
keymap("n", "[e", function()
  require("lspsaga.diagnostic").goto_prev({ severity = vim.diagnostic.severity.ERROR })
end, opts)

keymap("n", "]e", function()
  require("lspsaga.diagnostic").goto_next({ severity = vim.diagnostic.severity.ERROR })
end, opts)

keymap("n","<leader>o", "<cmd>LSoutlineToggle<CR>",{ silent = true }) -- outline

