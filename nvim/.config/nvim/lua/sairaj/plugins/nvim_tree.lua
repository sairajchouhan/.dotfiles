return {
  'nvim-tree/nvim-tree.lua',
  dependencies = { 'nvim-tree/nvim-web-devicons' },
  opts = {
    git = {
      ignore = false,
    },
    update_focused_file = {
      enable = true,
    },
    view = {
      float = {
        enable = false,
      },
      adaptive_size = true,
    },
    renderer = {
      icons = {
        git_placement = 'signcolumn',
        glyphs = {
          git = {
            unstaged = 'M',
            renamed = 'R',
            untracked = '?',
            deleted = 'D',
            ignored = '◌',
            unmerged = '',
            staged = '',
          },
        },
      },
    },
  },
}
