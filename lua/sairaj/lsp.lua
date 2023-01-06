local status_ok, lspconfig = pcall(require, "lspconfig")

if (not status_ok) then
  return
end


-- setup
local icons = require "sairaj.icons"
local signs = {
  { name = "DiagnosticSignError", text = icons.diagnostics.Error },
  { name = "DiagnosticSignWarn", text = icons.diagnostics.Warning },
  { name = "DiagnosticSignHint", text = icons.diagnostics.Hint },
  { name = "DiagnosticSignInfo", text = icons.diagnostics.Information },
}

for _, sign in ipairs(signs) do
  vim.fn.sign_define(sign.name, { texthl = sign.name, text = sign.text, numhl = "" })
end

local config = {
  -- disable virtual text
  virtual_lines = true,
  virtual_text = true,
  --[[ virtual_text = { ]]
  --[[   -- spacing = 7, ]]
  --[[   -- update_in_insert = false, ]]
  --[[   -- severity_sort = true, ]]
  --[[   -- prefix = "<-", ]]
  --[[   prefix = " ●", ]]
  --[[   source = "if_many", -- Or "always" ]]
  --[[   -- format = function(diag) ]]
  --[[   --   return diag.message .. "blah" ]]
  --[[   -- end, ]]
  --[[ }, ]]

  -- show signs
  signs = {
    active = signs,
  },
  update_in_insert = true,
  underline = true,
  severity_sort = true,
  float = {
    focusable = true,
    style = "minimal",
    border = "rounded",
    -- border = {"▄","▄","▄","█","▀","▀","▀","█"},
    source = "if_many", -- Or "always"
    header = "",
    prefix = "",
    -- width = 40,
  },
}

vim.diagnostic.config(config)

-- for auto complete
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)

local servers = { 'tsserver', 'svelte', 'gopls', 'rust_analyzer', 'denols', 'sumneko_lua', 'clangd' }

for _, lsp in ipairs(servers) do
  local root_dir;


  if lsp == 'denols' then
    root_dir = lspconfig.util.root_pattern("deno.json", "deno.jsonc")
  end

  if lsp == 'tsserver' then
    root_dir = lspconfig.util.root_pattern("package.json", "tsconfig.json", "jsconfig.json")
  end

  lspconfig[lsp].setup {
    capabilities = capabilities,
    on_attach = function(client, bufnr)
      local bufopts = { noremap = true, silent = true, buffer = 0 }
      vim.keymap.set('n', 'gd', vim.lsp.buf.definition, bufopts)
      vim.keymap.set('n', 'gt', vim.lsp.buf.type_definition, bufopts)
      vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, bufopts)
    end,
    root_dir = root_dir,
    settings = {
      Lua = {
        diagnostics = {
          globals = {'vim'}
        }
      }
    }
  }
end

lspconfig.eslint.setup {
  autostart = true,
}


















-- format on save
--[[ local lsp_formating_group = vim.api.nvim_create_augroup("LspFormatting", {}) ]]
--[[ if client.server_capabilities.documentFormattingProvider then ]]
--[[   vim.api.nvim_clear_autocmds { buffer = 0, group = lsp_formating_group  } ]]
--[[   vim.api.nvim_create_autocmd("BufWritePre", { ]]
--[[     group = lsp_formating_group, ]]
--[[     buffer = bufnr, ]]
--[[     callback = function() vim.lsp.buf.format() end ]]
--[[   }) ]]
--[[ end ]]
