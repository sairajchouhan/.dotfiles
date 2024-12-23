local function merge_highlights(current, new)
  -- Convert decimal fg to hex if it exists
  if current.fg then
    new.fg = string.format('#%06x', current.fg)
  end

  -- Copy non-color attributes
  return vim.tbl_extend(
    'force',
    vim.tbl_filter(function(k)
      return k ~= 'fg' and k ~= 'bg'
    end, current),
    new
  )
end

local highlights = {
  BlinkCmpMenu = { bg = '#000000' },
  BlinkCmpMenuBorder = { fg = '#0db9d7' },
}

return {
  'saghen/blink.cmp',
  -- optional: provides snippets for the snippet source
  dependencies = {
    'rafamadriz/friendly-snippets',
    {
      'L3MON4D3/LuaSnip',
      version = 'v2.*',
    },
  },
  version = '*',
  opts_extend = { 'sources.default' },
  config = function()
    ---@module 'blink.cmp'
    ---@type blink.cmp.Config
    local opts = {
      -- 'default' for mappings similar to built-in completion
      -- 'super-tab' for mappings similar to vscode (tab to accept, arrow keys to navigate)
      -- 'enter' for mappings similar to 'super-tab' but with 'enter' to accept
      -- See the full "keymap" documentation for information on defining your own keymap.
      keymap = { preset = 'enter' },

      appearance = {
        -- use_nvim_cmp_as_default = true,
        nerd_font_variant = 'mono',
      },
      sources = {
        default = { 'lsp', 'path', 'snippets', 'buffer' },
        -- disables command line auto completion
        cmdline = {},
      },
      completion = {
        menu = { border = 'rounded' },
      },
      signature = { enabled = true, window = { border = 'rounded' } },
      snippets = {
        expand = function(snippet)
          require('luasnip').lsp_expand(snippet)
        end,
        active = function(filter)
          if filter and filter.direction then
            return require('luasnip').jumpable(filter.direction)
          end
          return require('luasnip').in_snippet()
        end,
        jump = function(direction)
          require('luasnip').jump(direction)
        end,
      },
    }
    require('blink-cmp').setup(opts)

    local luasnip = require 'luasnip'

    luasnip.config.setup {}
    require('luasnip.loaders.from_vscode').lazy_load()

    for group, colors in pairs(highlights) do
      local current = vim.api.nvim_get_hl(0, { name = group })
      vim.api.nvim_set_hl(0, group, merge_highlights(current, colors))
    end
  end,
}
