return {
  'stevearc/conform.nvim',
  event = { 'BufReadPre', 'BufNewFile' },
  keys = {
    {
      'F',
      function()
        require('conform').format({ async = true, lsp_format = 'fallback' }, function(_, did_edit)
          if did_edit then
            vim.cmd 'write'
          end
        end)
      end,
      mode = '',
      desc = '[F]ormat buffer',
    },
  },
  config = function()
    local conform = require 'conform'

    conform.setup {
      formatters_by_ft = {
        javascript = { 'prettierd' },
        typescript = { 'prettierd' },
        javascriptreact = { 'prettierd' },
        typescriptreact = { 'prettierd' },
        svelte = { 'prettierd' },
        css = { 'prettierd' },
        html = { 'prettierd' },
        json = { 'prettierd' },
        yaml = { 'prettierd' },
        markdown = { 'prettierd' },
        graphql = { 'prettierd' },
        liquid = { 'prettierd' },
        lua = { 'stylua' },
        toml = { 'taplo' },
      },
      format_on_save = function(bufnr)
        local disable_filetypes =
          { javascript = true, typescript = true, javascriptreact = true, typescriptreact = true }

        local lsp_format_opt
        if disable_filetypes[vim.bo[bufnr].filetype] then
          lsp_format_opt = 'never'
        else
          lsp_format_opt = 'fallback'
        end

        return {
          timeout_ms = 500,
          lsp_format = lsp_format_opt,
        }
      end,
    }
  end,
}
