local Plug = vim.fn['plug#']

vim.call('plug#begin', '~/.config/nvim/plugged')
  Plug 'kyazdani42/nvim-web-devicons'
  Plug 'nvim-lualine/lualine.nvim'
  Plug 'kyazdani42/nvim-tree.lua'
  Plug 'kdheepak/tabline.nvim'

  -- Git related
  Plug 'lewis6991/gitsigns.nvim'

  -- Colorschemes
  Plug 'ellisonleao/gruvbox.nvim'
  Plug 'bluz71/vim-moonfly-colors'
  Plug('folke/tokyonight.nvim', {['branch'] = 'main'})
  Plug('rose-pine/neovim', {['as'] = 'rose-pine', ['tag'] = 'v1.*'})
  Plug 'ishan9299/nvim-solarized-lua'

  -- LSP and Completion
  Plug 'neovim/nvim-lspconfig'
  Plug 'hrsh7th/cmp-nvim-lsp'
  Plug 'hrsh7th/cmp-buffer'
  Plug 'hrsh7th/cmp-path'
  Plug 'hrsh7th/nvim-cmp'
  Plug 'ray-x/lsp_signature.nvim'
  Plug 'onsails/lspkind-nvim'
  Plug 'L3MON4D3/LuaSnip'
  Plug 'saadparwaiz1/cmp_luasnip'
  Plug 'rafamadriz/friendly-snippets'
  Plug 'j-hui/fidget.nvim'

  -- Treesitter
  Plug('nvim-treesitter/nvim-treesitter', {['do'] = ':TSUpdate'})

  -- Telescope
  Plug 'nvim-lua/plenary.nvim'
  Plug 'nvim-telescope/telescope.nvim'
  Plug('nvim-telescope/telescope-fzf-native.nvim', {['do'] = 'make'})
  Plug 'benfowler/telescope-luasnip.nvim'

  -- Comments
  Plug 'folke/todo-comments.nvim'
  Plug 'numToStr/Comment.nvim'
  Plug 'JoosepAlviste/nvim-ts-context-commentstring'
vim.call('plug#end')
