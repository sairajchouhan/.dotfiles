return {
  'stevearc/conform.nvim',
  event = { 'BufWritePre' },
  keys = {
    {
      'F',
      function()
        require('conform').format { async = true, lsp_format = 'fallback' }
      end,
      mode = '',
      desc = '[F]ormat buffer',
    },
  },
  opts = {
    -- format_on_save = function(bufnr)
    --   if vim.g.disable_autoformat or vim.b[bufnr].disable_autoformat then
    --     return
    --   end
    --   return { timeout_ms = 500, lsp_format = 'fallback' }
    -- end,
    format_on_save = false,
    formatters_by_ft = {
      lua = { 'stylua' },
      rust = { 'rustfmt' },
      javascript = { 'prettierd' },
      typescript = { 'prettierd' },
      javascriptreact = { 'prettierd' },
      typescriptreact = { 'prettierd' },
      css = { 'prettierd' },
      html = { 'prettierd' },
      json = { 'prettierd' },
      yaml = { 'prettierd' },
      markdown = { 'prettierd' },
      graphql = { 'prettierd' },
    },
  },
  config = function()
    vim.api.nvim_create_user_command('FormatOnSaveDisable', function(args)
      if args.bang then
        -- FormatDisable! will disable formatting just for this buffer
        vim.b.disable_autoformat = true
      else
        vim.g.disable_autoformat = true
      end
    end, {
      desc = 'Disable autoformat-on-save',
      bang = true,
    })

    vim.api.nvim_create_user_command('FormatOnSaveEnable', function()
      vim.b.disable_autoformat = false
      vim.g.disable_autoformat = false
    end, {
      desc = 'Re-enable autoformat-on-save',
    })
  end
}
