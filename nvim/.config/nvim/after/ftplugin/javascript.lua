local ls = require 'luasnip'
local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node

local snippets = {
  s('clg', {
    t 'console.log(',
    i(1),
    t ')',
  }),
}

ls.add_snippets('javascript', snippets, { key = 'js_snippets' })
