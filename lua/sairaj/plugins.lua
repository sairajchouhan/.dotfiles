return require('packer').startup(function()
	use 'wbthomason/packer.nvim' -- packer iteself
  use 'kyazdani42/nvim-web-devicons' -- icons in file expolrer
	use { 'nvim-lualine/lualine.nvim' } -- lua status line
  use { 'kyazdani42/nvim-tree.lua', tag = 'nightly' } -- file explorer
  use "nvim-lua/popup.nvim" -- An implementation of the Popup API from vim in Neovim
  use "nvim-lua/plenary.nvim" -- Useful lua functions used ny lots of plugins
  use "windwp/nvim-autopairs" -- complets ( => ()
  use 'windwp/nvim-ts-autotag' -- auto close tags and auto rename tags


  -- color schemes
	use { 'catppuccin/nvim', as = 'catppuccin' } -- color theme
  use 'folke/tokyonight.nvim'
  
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

  -- heavy features
  use 'neovim/nvim-lspconfig' -- Configurations for Nvim LSP
  use { "glepnir/lspsaga.nvim", branch = "main" }
  use { "williamboman/mason.nvim" }
  use { "williamboman/mason-lspconfig.nvim" }
  use "jose-elias-alvarez/null-ls.nvim"
  use "simrat39/rust-tools.nvim"

  use { 'nvim-treesitter/nvim-treesitter', run = ':TSUpdate' } -- treesitter
  use "nvim-telescope/telescope.nvim" -- telescope
  use { "numToStr/Comment.nvim" } -- comment plugin
  use { "JoosepAlviste/nvim-ts-context-commentstring" } -- ts context aware commenting

  use {'lewis6991/gitsigns.nvim', commit = "851cd32caaea84f303c4fdf51d72dfa5fcd795bb"}
  use { 'akinsho/bufferline.nvim', tag = "v2.*" }
  use {"akinsho/toggleterm.nvim" }
  use "folke/which-key.nvim"
  use 'norcalli/nvim-colorizer.lua'


  -- themes
  use "EdenEast/nightfox.nvim" 
  use "olimorris/onedarkpro.nvim"   


end)

