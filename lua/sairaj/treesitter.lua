local status, treesitter = pcall(require, "nvim-treesitter.configs")
if (not status) then 
  return
end


treesitter.setup {
  ensure_installed = {
    "tsx",
    "json",
    "yaml",
    "css",
    "html",
    "lua"
  },
  ignore_install = {}, -- List of parsers to ignore installing
  highlight = {
    enable = true, -- false will disable the whole extension
    disable = {}, -- list of language that will be disabled
  },
  indent = { 
    enable = true,
    disable = {}
  },
}

local parser_config = require "nvim-treesitter.parsers".get_parser_configs()
parser_config.tsx.filetype_to_parsername = { "javascript", "typescript.tsx" }
