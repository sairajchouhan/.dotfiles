local status_ok, null_ls = pcall(require, "null-ls")

if not status_ok then
  return
end


local augroup = vim.api.nvim_create_augroup("LspFormatting", {})


null_ls.setup({
  sources = {
    null_ls.builtins.diagnostics.eslint_d,
    null_ls.builtins.formatting.prettierd
  },
})

  --[[ on_attach = function(client, bufnr) ]]
  --[[   if client.server_capabilities.documentFormattingProvider then ]]
  --[[     vim.api.nvim_clear_autocmds { buffer = 0, group = augroup_format } ]]
  --[[     vim.api.nvim_create_autocmd("BufWritePre", { ]]
  --[[       group = augroup_format, ]]
  --[[       buffer = 0, ]]
  --[[       callback = function() vim.lsp.buf.format() end ]]
  --[[     }) ]]
  --[[   end ]]
  --[[ end, ]]
