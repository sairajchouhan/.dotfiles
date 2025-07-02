return {
  'L3MON4D3/LuaSnip',
  version = 'v2.*',
  config = function()
    local luasnip = require 'luasnip'
    luasnip.config.setup {}
    require('luasnip.loaders.from_vscode').lazy_load()
    require('luasnip.loaders.from_vscode').lazy_load { paths = { '../../snippets' } }
    local s = luasnip.snippet
    local t = luasnip.text_node
    local i = luasnip.insert_node

    luasnip.add_snippets('typescript', {
      s('clg', {
        t 'console.log("',
        i(1),
        t '")',
      }),
    })
    luasnip.add_snippets('typescriptreact', {
      s('clg', {
        t 'console.log("',
        i(1),
        t '")',
      }),
    })

    luasnip.add_snippets('typescript', {
      s('cer', {
        t 'console.error("',
        i(1),
        t '")',
      }),
    })
    luasnip.add_snippets('typescriptreact', {
      s('clg', {
        t 'console.error("',
        i(1),
        t '")',
      }),
    })
  end,
}
