local status_ok, mason = pcall(require, "mason")
local status_ok, mason_lsp_config= pcall(require, "mason-lspconfig")

if not status_ok then
  return
end


if not status_ok then
  return
end


mason.setup{}
mason_lsp_config.setup{
  ensure_installed = {'tailwindcss', 'rust_analyzer' },
}


require('lspconfig').tailwindcss.setup{}
require('lspconfig').rust_analyzer.setup{}

