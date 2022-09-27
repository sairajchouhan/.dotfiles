return require('packer').startup(function()
	use 'wbthomason/packer.nvim' -- packer iteself
  use 'kyazdani42/nvim-web-devicons' -- icons in file expolrer
	use { 'catppuccin/nvim', as = 'catppuccin' } -- color theme
	use { 'nvim-lualine/lualine.nvim' } -- better 100% lua status line
  use { 'kyazdani42/nvim-tree.lua', tag = 'nightly' } -- file explorer
  use "nvim-lua/popup.nvim" -- An implementation of the Popup API from vim in Neovim
  use "nvim-lua/plenary.nvim" -- Useful lua functions used ny lots of plugins
  use "windwp/nvim-autopairs"
  
    -- cmp plugins
  use "hrsh7th/nvim-cmp" -- The completion plugin
  use "hrsh7th/cmp-buffer" -- buffer completions
  use "hrsh7th/cmp-path" -- path completions
  use "hrsh7th/cmp-cmdline" -- cmdline completions
  use "saadparwaiz1/cmp_luasnip" -- snippet completions
  use "hrsh7th/cmp-nvim-lsp" -- provides autocompltete for neovim lsp

  -- snippets
  use "L3MON4D3/LuaSnip" --snippet engine
  use "rafamadriz/friendly-snippets" -- a bunch of snippets to use

  -- lsp
  use 'neovim/nvim-lspconfig' -- Configurations for Nvim LSP


  -- treesitter
  use { 'nvim-treesitter/nvim-treesitter', run = ':TSUpdate' } 

  -- telescope
  use "nvim-telescope/telescope.nvim"
  use 'nvim-telescope/telescope-media-files.nvim'

  -- comments
  use { "numToStr/Comment.nvim" }
  use { "JoosepAlviste/nvim-ts-context-commentstring" }

  -- git signs
  use 'lewis6991/gitsigns.nvim'

  -- currently doing this for eslint
  use 'jose-elias-alvarez/null-ls.nvim'



end)
