return {
  'hrsh7th/nvim-cmp',
  event = 'InsertEnter',
  dependencies = {
    -- this is the snippet engine, the core of how snippets work, it's just necessary for snippets to work
    {
      'L3MON4D3/LuaSnip',
      build = 'make install_jsregexp',
    },
    -- these are the sources for the cmp, like from how many different places I should show completions
    'hrsh7th/cmp-nvim-lsp',
    'hrsh7th/cmp-path',
    'saadparwaiz1/cmp_luasnip',

    'rafamadriz/friendly-snippets',
    'onsails/lspkind.nvim',
  },
  config = function()
    local cmp = require 'cmp'
    local luasnip = require 'luasnip'

    luasnip.config.setup {}
    require('luasnip.loaders.from_vscode').lazy_load()
    local lspkind = require 'lspkind'

    cmp.setup {
      window = {
        completion = cmp.config.window.bordered(),
        documentation = cmp.config.window.bordered(),
      },
      snippet = {
        expand = function(args)
          luasnip.lsp_expand(args.body)
        end,
      },
      completion = { completeopt = 'menu,menuone,noinsert' },
      ---@diagnostic disable-next-line: missing-fields
      formatting = {
        format = lspkind.cmp_format {
          mode = 'symbol_text',
          maxwidth = 50,
          menu = {
            nvim_lsp = '[LSP]',
            path = '[Path]',
            buffer = '[Buffer]',
          },
          show_labelDetails = false,
          ellipsis_char = '...',
        },
      },

      mapping = cmp.mapping.preset.insert {
        ['<C-n>'] = cmp.mapping.select_next_item(),
        ['<C-p>'] = cmp.mapping.select_prev_item(),
        ['<C-b>'] = cmp.mapping.scroll_docs(-4), -- Scroll the documentation window [b]ack / [f]orward
        ['<C-f>'] = cmp.mapping.scroll_docs(4),
        ['<CR>'] = cmp.mapping.confirm { select = true },
        ['<C-Space>'] = cmp.mapping.complete {},
        ['<C-l>'] = cmp.mapping(function()
          if luasnip.expand_or_locally_jumpable() then
            luasnip.expand_or_jump()
          end
        end, { 'i', 's' }),
        ['<C-h>'] = cmp.mapping(function()
          if luasnip.locally_jumpable(-1) then
            luasnip.jump(-1)
          end
        end, { 'i', 's' }),
      },
      sources = {
        { name = 'nvim_lsp' },
        { name = 'luasnip', max_item_count = 5 },
        { name = 'path' },
      },
    }
  end,
}
