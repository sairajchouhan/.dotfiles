if vim.g.vscode then
  require 'sairaj.opts'
  return
end

require 'sairaj.globals'
require 'sairaj.opts'
require 'sairaj.remaps'

vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = vim.api.nvim_create_augroup('highlight-yank', { clear = true }),
  callback = function()
    vim.highlight.on_yank {
      timeout = 30,
    }
  end,
})

-- [[ Install `lazy.nvim` plugin manager ]]
--    See `:help lazy.nvim.txt` or https://github.com/folke/lazy.nvim for more info
local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'
if not vim.loop.fs_stat(lazypath) then
  local lazyrepo = 'https://github.com/folke/lazy.nvim.git'
  vim.fn.system { 'git', 'clone', '--filter=blob:none', '--branch=stable', lazyrepo, lazypath }
end ---@diagnostic disable-next-line: undefined-field
vim.opt.rtp:prepend(lazypath)

require('lazy').setup({
  'tpope/vim-sleuth', -- Detect tabstop and shiftwidth automatically
  -- 'github/copilot.vim',
  'JoosepAlviste/nvim-ts-context-commentstring',
  {
    'norcalli/nvim-colorizer.lua',
    config = function()
      require('colorizer').setup()
    end,
  },
  {
    'numToStr/Comment.nvim',
    config = function()
      ---@diagnostic disable: missing-fields
      require('Comment').setup {
        pre_hook = function()
          return vim.bo.commentstring
        end,
      }
    end,
  },
  {
    'folke/which-key.nvim',
    event = 'VimEnter', -- Sets the loading event to 'VimEnter'
    config = function() -- This is the function that runs, AFTER loading
      require('which-key').setup()

      -- Document existing key chains
      require('which-key').register {
        ['<leader>c'] = { name = '[C]ode', _ = 'which_key_ignore' },
        ['<leader>d'] = { name = '[D]ocument', _ = 'which_key_ignore' },
        ['<leader>r'] = { name = '[R]ename', _ = 'which_key_ignore' },
        ['<leader>s'] = { name = '[S]earch', _ = 'which_key_ignore' },
        ['<leader>w'] = { name = '[W]orkspace', _ = 'which_key_ignore' },
        ['<leader>t'] = { name = '[T]oggle', _ = 'which_key_ignore' },
        ['<leader>h'] = { name = 'Git [H]unk', _ = 'which_key_ignore' },
      }
      -- visual mode
      require('which-key').register({
        ['<leader>h'] = { 'Git [H]unk' },
      }, { mode = 'v' })
    end,
  },
  {
    -- Change the name of the colorscheme plugin below, and then
    -- change the command in the config to whatever the name of that colorscheme is.
    --
    -- If you want to see what colorschemes are already installed, you can use `:Telescope colorscheme`.
    'folke/tokyonight.nvim',
    priority = 1000, -- Make sure to load this before all the other start plugins.
    opts = {
      transparent = true,
      style = 'night',
      styles = {
        sidebars = 'transparent',
      },
    },
    init = function()
      -- 'tokyonight-storm', 'tokyonight-moon', or 'tokyonight-day'.
      vim.cmd.colorscheme 'tokyonight-night'
    end,
  },

  -- Highlight todo, notes, etc in comments
  {
    'folke/todo-comments.nvim',
    event = 'VimEnter',
    dependencies = { 'nvim-lua/plenary.nvim' },
    opts = { signs = true },
    keys = {
      {
        ']t',
        function()
          require('todo-comments').jump_next()
        end,
        desc = 'Next Todo Comment',
      },
      {
        '[t',
        function()
          require('todo-comments').jump_prev()
        end,
        desc = 'Previous Todo Comment',
      },
      { '<leader>ft', '<cmd>TodoTelescope<cr>', desc = 'Todo search telescope' },
    },
  },

  { 'nvim-treesitter/nvim-treesitter-context' },

  {
    'nvim-lualine/lualine.nvim',
    opts = {
      options = {
        theme = 'tokyonight',
      },
    },
  },

  {
    'goolord/alpha-nvim',
    config = function()
      require('alpha').setup(require('alpha.themes.dashboard').config)
    end,
  },

  -- require 'sairaj.plugins.debug',
  require 'sairaj.plugins.indent_line',
  require 'sairaj.plugins.autopairs',
  require 'sairaj.plugins.autotag',
  require 'sairaj.plugins.gitsigns',
  require 'sairaj.plugins.nvim_tree',
  require 'sairaj.plugins.telescope',
  require 'sairaj.plugins.lsp',
  require 'sairaj.plugins.cmp',
  require 'sairaj.plugins.treesitter',
  require 'sairaj.plugins.formatting',
  require 'sairaj.plugins.lint',
  require 'sairaj.plugins.bufferline',
  require 'sairaj.plugins.vim_tmux_navigator',
  -- NOTE: The import below can automatically add your own plugins, configuration, etc from `lua/custom/plugins/*.lua`
  --    This is the easiest way to modularize your config.
  --
  { import = 'custom.plugins' },
}, {
  ui = {
    icons = {},
  },
})

-- The line beneath this is called `modeline`. See `:help modeline`
-- vim: ts=2 sts=2 sw=2 et
