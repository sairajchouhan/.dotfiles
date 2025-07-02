return {
  'saghen/blink.cmp',
  dependencies = { 'rafamadriz/friendly-snippets' },
  version = '1.*',
  ---@module 'blink.cmp'
  ---@type blink.cmp.Config
  opts = {
    keymap = { preset = 'enter' },
    appearance = {
      nerd_font_variant = 'mono',
    },
    completion = {
      menu = {
        border = 'rounded',
        draw = {
          columns = {
            { 'kind_icon' },
            { 'label', 'label_description', gap = 1 },
            -- { 'source_name' },
          },
          components = {
            -- source_name = {
            --   text = function(ctx)
            --     return '[' .. ctx.source_name .. ']'
            --   end,
            -- },
          },
        },
      },
      documentation = {
        window = { border = 'rounded' },
        auto_show = true,
        -- auto_show_delay_ms = 200,
      },
      ghost_text = { enabled = true },
      list = {
        selection = {
          auto_insert = false,
        },
      },
      accept = {
        auto_brackets = {
          enabled = false,
        },
      },
    },
    signature = { window = { border = 'rounded' }, enabled = true },
    snippets = { preset = 'luasnip' },
    sources = {
      default = { 'lsp', 'path', 'snippets', 'buffer' },
    },
    fuzzy = { implementation = 'prefer_rust_with_warning' },
  },
  opts_extend = { 'sources.default' },
}
