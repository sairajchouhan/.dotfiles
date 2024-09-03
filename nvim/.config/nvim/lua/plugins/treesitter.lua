-- TODO: have to get text-objects for treesitter
-- https://github.com/nvim-treesitter/nvim-treesitter-textobjects
return {
  {
    'nvim-treesitter/nvim-treesitter',
    dependencies = {},
    build = ':TSUpdate',
    event = { 'BufReadPre', 'BufNewFile' },
    opts = {
      ensure_installed = {
        'bash',
        'c',
        'diff',
        'html',
        'lua',
        'luadoc',
        'markdown',
        'markdown_inline',
        'query',
        'vim',
        'vimdoc',
        'json',
        'javascript',
        'typescript',
        'tsx',
        'yaml',
        'css',
        'prisma',
        'gitignore',
      },
      auto_install = true,
      highlight = {
        enable = true,
        additional_vim_regex_highlighting = false,
      },
      indent = { enable = true },
    },
    config = function(_, opts)
      require('nvim-treesitter.configs').setup(opts)
      vim.filetype.add {
        pattern = {
          ['%.env%.[%w_.-]+'] = 'sh',
        },
      }
    end,
  },
  {
    'nvim-treesitter/nvim-treesitter-context',
    opts = {
      multiline_threshold = 4,
      max_lines = 4
    }
  },
}
