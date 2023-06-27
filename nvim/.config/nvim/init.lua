require('sairaj.globals')


vim.g.mapleader = ' '
vim.g.maplocalleader = ' '
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system {
    'git',
    'clone',
    '--filter=blob:none',
    'https://github.com/folke/lazy.nvim.git',
    '--branch=stable', -- latest stable release
    lazypath,
  }
end
vim.opt.rtp:prepend(lazypath)

require('lazy').setup({
  -- Detect tabstop and shiftwidth automatically
  'tpope/vim-sleuth',
  "github/copilot.vim",
  -- NOTE: This is where your plugins related to LSP can be installed.
  --  The configuration is done below. Search for lspconfig to find it below.
  --
  {
    -- LSP Configuration & Plugins
    'neovim/nvim-lspconfig',
    dependencies = {
      -- Automatically install LSPs to stdpath for neovim
      'williamboman/mason.nvim',
      'williamboman/mason-lspconfig.nvim',

      'simrat39/rust-tools.nvim',

      -- NOTE: `opts = {}` is the same as calling `require('fidget').setup({})`
      { 'j-hui/fidget.nvim',             opts = {} },

      -- Additional lua configuration, makes nvim stuff amazing!
      'folke/neodev.nvim',

      "jose-elias-alvarez/null-ls.nvim",
      "jay-babu/mason-null-ls.nvim",
      { "simrat39/symbols-outline.nvim", opts = {} }
    },
  },
  {
    -- Autocompletion
    'hrsh7th/nvim-cmp',               -- completion plugin writter in lua
    dependencies = {
      'hrsh7th/cmp-nvim-lsp',         -- LSP source for nvim-cmp
      'hrsh7th/cmp-path',             -- Path source for nvim-cmp

      'L3MON4D3/LuaSnip',             -- Snippets engine for neovim
      'hrsh7th/cmp-buffer',           -- Buffer source for nvim-cmp
      'saadparwaiz1/cmp_luasnip',     -- Snippets source for nvim-cmp
      'rafamadriz/friendly-snippets', -- Actual snippets for LuaSnip
    },
  },

  {
    -- Adds git releated signs to the gutter, as well as utilities for managing changes
    'lewis6991/gitsigns.nvim',
    config = true
  },

  {
    "folke/tokyonight.nvim",
    lazy = false,
    priority = 1000,
    opts = {
      style = "night",
      transparent = true,
    },
    init = function()
      vim.cmd.colorscheme 'tokyonight'
    end
  },

  {
    -- Set lualine as statusline
    'nvim-lualine/lualine.nvim',
    -- See `:help lualine.txt`
    opts = {
      options = {
        icons_enabled = false,
        theme = 'tokyonight',
        component_separators = '|',
        section_separators = '',
      },
    },
  },

  {
    -- Add indentation guides even on blank lines
    'lukas-reineke/indent-blankline.nvim',
    -- Enable `lukas-reineke/indent-blankline.nvim`
    -- See `:help indent_blankline.txt`
    opts = {
      char = '┊',
      show_trailing_blankline_indent = false,
    },
  },

  -- "gc" to comment visual regions/lines
  {
    'numToStr/Comment.nvim',
    config = function()
      require('Comment').setup {
        pre_hook = require('ts_context_commentstring.integrations.comment_nvim').create_pre_hook(),
      }
    end
  },
  { 'JoosepAlviste/nvim-ts-context-commentstring' },

  -- Fuzzy Finder (files, lsp, etc)
  { 'nvim-telescope/telescope.nvim',              version = '*', dependencies = { 'nvim-lua/plenary.nvim' } },

  -- Fuzzy Finder Algorithm which requires local dependencies to be built.
  -- Only load if `make` is available. Make sure you have the system
  -- requirements installed.
  {
    'nvim-telescope/telescope-fzf-native.nvim',
    -- NOTE: If you are having trouble with this installation,
    --       refer to the README for telescope-fzf-native for more instructions.
    build = 'make',
    cond = function()
      return vim.fn.executable 'make' == 1
    end,
  },

  {
    -- Highlight, edit, and navigate code
    'nvim-treesitter/nvim-treesitter',
    dependencies = {
      'nvim-treesitter/nvim-treesitter-textobjects',
    },
    config = function()
      pcall(require('nvim-treesitter.install').update { with_sync = true })
    end,
  },

  { "nvim-treesitter/nvim-treesitter-context" },

  {
    'windwp/nvim-autopairs',
    config = function()
      require("nvim-autopairs").setup {};
    end
  },

  {
    "windwp/nvim-ts-autotag",
    config = function()
      require('nvim-ts-autotag').setup()
    end
  },

  {
    "norcalli/nvim-colorizer.lua",
    config = function()
      require("colorizer").setup()
    end
  },

  {
    "folke/todo-comments.nvim",
    opts = {}
  },
  {
    'nvim-tree/nvim-tree.lua',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    opts = {
      git = {
        ignore = false
      },
      update_focused_file = {
        enable = true,
      },
      view = {
        float = {
          enable = true
        },
        adaptive_size = true
      },
      renderer = {
        icons = {
          git_placement = "signcolumn",
          glyphs = {
            git = {
              unstaged = "M",
              renamed = "R",
              untracked = "?",
              deleted = "D",
              ignored = "◌",
              unmerged = "",
              staged = "",
            }
          }
        },
      }
    }
  },
  {
    "sairajchouhan/blame.nvim",
    config = function()
      require("blame").setup()
    end,
    dev = false
  }

  -- NOTE: Next Step on Your Neovim Journey: Add/Configure additional "plugins" for kickstart
  --       These are some example plugins that I've included in the kickstart repository.
  --       Uncomment any of the lines below to enable them.
  -- require 'kickstart.plugins.autoformat',
  -- require 'kickstart.plugins.debug',

  -- NOTE: The import below automatically adds your own plugins, configuration, etc from `lua/custom/plugins/*.lua`
  --    You can use this folder to prevent any conflicts with this init.lua if you're interested in keeping
  --    up-to-date with whatever is in the kickstart repo.
  --
  --    For additional information see: https://github.com/folke/lazy.nvim#-structuring-your-plugins
  --
  --    An additional note is that if you only copied in the `init.lua`, you can just comment this line
  --    to get rid of the warning telling you that there are not plugins in `lua/custom/plugins/`.
  -- { import = 'custom.plugins' },
}, {
  dev = {
    path = "~/mine/plugins",
  },
  ui = {
    border = "rounded"
  }
})

-- [[ Setting options ]]
-- See `:help vim.o`

-- relativenumber things
vim.o.number = true
vim.o.relativenumber = true

-- tabs magic
vim.o.tabstop = 2
vim.o.softtabstop = 2
vim.o.shiftwidth = 2
vim.o.expandtab = true
vim.o.smarttab = true
vim.o.smartindent = true

vim.o.scrolloff = 8
-- Set highlight on search
vim.o.hlsearch = true

-- Make line numbers default
vim.wo.number = true

-- Enable mouse mode
vim.o.mouse = 'a'

-- Sync clipboard between OS and Neovim.
--  Remove this option if you want your OS clipboard to remain independent.
--  See `:help 'clipboard'`
vim.o.clipboard = 'unnamedplus'

-- Enable break indent
vim.o.breakindent = true

-- Save undo history
vim.o.undofile = true

-- Case insensitive searching UNLESS /C or capital in search
vim.o.ignorecase = true
vim.o.smartcase = true

-- Keep signcolumn on by default
vim.wo.signcolumn = 'yes'

-- Decrease update time
vim.o.updatetime = 250
vim.o.timeout = true
vim.o.timeoutlen = 300

-- Set completeopt to have a better completion experience
vim.o.completeopt = 'menuone,noselect'

-- NOTE: You should make sure your terminal supports this
vim.o.termguicolors = true

vim.o.wrap = false

vim.o.swapfile = false -- get'em out

-- [[ Basic Keymaps ]]

-- Keymaps for better default experience
-- See `:help vim.keymap.set()`

local highlight_group = vim.api.nvim_create_augroup('YankHighlight', { clear = true })
vim.api.nvim_create_autocmd('TextYankPost', {
  callback = function()
    vim.highlight.on_yank({
      timeout = 30
    })
  end,
  group = highlight_group,
  pattern = '*',
})

-- vim.api.nvim_create_autocmd("VimEnter", {
--   callback = function()
--     vim.cmd("silent! lua require('telescope.builtin').find_files()")
--   end
-- })

require('sairaj.telescope')
require('sairaj.treesitter')
require('sairaj.lsp')
require('sairaj.cmp')
require('sairaj.null-ls')


-------------- MY REMAPS --------------------

local opts = { noremap = true, silent = true }
local keymap = vim.api.nvim_set_keymap

vim.keymap.set({ 'n', 'v' }, '<Space>', '<Nop>', { silent = true })
vim.keymap.set('n', 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
vim.keymap.set('n', 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

keymap('i', '<C-c>', '<ESC>', opts)
keymap('n', '<leader>e', ':NvimTreeToggle<CR>', opts)
keymap('n', '<cr>', '<cmd>noh<cr><cr>', opts)

-- navigating between splits
keymap('n', "<C-h>", "<C-w>h", opts)
keymap('n', "<C-j>", "<C-w>j", opts)
keymap('n', "<C-k>", "<C-w>k", opts)
keymap('n', "<C-l>", "<C-w>l", opts)

-- resize windows
keymap("n", "<C-S-Up>", ":resize -2<CR>", opts)
keymap("n", "<C-S-Down>", ":resize +2<CR>", opts)
keymap("n", "<C-S-Left>", ":vertical resize -2<CR>", opts)
keymap("n", "<C-S-Right>", ":vertical resize +2<CR>", opts)

-- move lines up and down
keymap("v", "J", ":m '>+1<CR>gv=gv", opts)
keymap("v", "K", ":m '<-2<CR>gv=gv", opts)

-- search terms stay in middle of screen
keymap("n", "n", "nzzzv", opts)
keymap("n", "N", "Nzzzv", opts)

keymap('n', 'x', '"_x', opts)  -- do not yank on x
keymap('v', 'p', '"_dP', opts) -- do not update the register on paste

keymap("n", "<leader>o", ":SymbolsOutline<cr>", opts)

keymap("n", "<leader>bl", ":BlameLineOnce<cr>", opts)

-----------------------------------------

-- The line beneath this is called `modeline`. See `:help modeline`
-- vim: ts=2 sts=2 sw=2 et
--
