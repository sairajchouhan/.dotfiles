local status_ok, lspsaga = pcall(require, "lspsaga")

if not status_ok then
  return
end

local keymap = vim.keymap.set

local opts = { noremap = true, silent = true }

lspsaga.setup({
  ui = {
    -- currently only round theme
    theme = 'round',
    -- border type can be single,double,rounded,solid,shadow.
    border = 'rounded',
    winblend = 0,
    expand = '',
    collapse = '',
    preview = ' ',
    code_action = '💡',
    diagnostic = '🐞',
    incoming = ' ',
    outgoing = ' ',
    colors = {
      --float window normal bakcground color
      normal_bg = '#1d1536',
      --title background color
      title_bg = '#afd700',
      red = '#e95678',
      magenta = '#b33076',
      orange = '#FF8700',
      yellow = '#f7bb3b',
      green = '#afd700',
      cyan = '#36d0e0',
      blue = '#61afef',
      purple = '#CBA6F7',
      white = '#d1d4cf',
      black = '#1c1c19',
    },
    kind = {},
  },

  --[[ border_style = "rounded", ]]
  code_action_lightbulb = {
    virtual_text = false,
  },
})

keymap("n", "gh", "<cmd>Lspsaga lsp_finder<CR>", opts) -- preview definition, implementations, references

keymap({ "n", "v" }, "<leader>ca", "<cmd>Lspsaga code_action<CR>", opts) -- code action

keymap("n", "<leader>rn", "<cmd>Lspsaga rename<CR>", opts) -- lsp rename

keymap("n", "K", "<cmd>Lspsaga hover_doc<CR>")

-- Show line diagnostics
keymap("n", ";d", "<cmd>Lspsaga show_line_diagnostics<CR>", opts)

-- Show cursor diagnostic
keymap("n", "<leader>cd", "<cmd>Lspsaga show_cursor_diagnostics<CR>", opts)

-- go to next and prev diagnostics
keymap("n", "[d", "<cmd>Lspsaga diagnostic_jump_prev<CR>zz", opts)
keymap("n", "]d", "<cmd>Lspsaga diagnostic_jump_next<CR>zz", opts)

-- only errors
keymap("n", "[e", function()
  require("lspsaga.diagnostic"):goto_prev({ severity = vim.diagnostic.severity.ERROR })
end, opts)

keymap("n", "]e", function()
  require("lspsaga.diagnostic"):goto_next({ severity = vim.diagnostic.severity.ERROR })
end, opts)

keymap("n", "<leader>o", "<cmd>Lspsaga outline<CR>")
