" neovim compatible plugins (using vim-plug as the plugin manager)

call plug#begin()

	" colorschemes
    Plug 'ayu-theme/ayu-vim'
    Plug 'rakr/vim-one'

    " iconsets
    Plug 'kyazdani42/nvim-web-devicons'
    Plug 'yamatsum/nvim-nonicons'

	" graphics
    Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
    Plug 'dstein64/nvim-scrollview', { 'branch': 'main' } " interactive scrollbar
    Plug 'lukas-reineke/indent-blankline.nvim' " indent guides
    Plug 'norcalli/nvim-colorizer.lua' " highlights hex codes with their colors
    Plug 'karb94/neoscroll.nvim' " smooth scrolling
    " Plug 'folke/twilight.nvim' " theatre mode for code
    " Plug 'folke/zen-mode.nvim' " enhanced twilight

    " status bar / notifier
    Plug 'hoob3rt/lualine.nvim'

	" enhancements
    Plug 'terrortylor/nvim-comment'
    Plug 'kosayoda/nvim-lightbulb'
    Plug 'Pocco81/AutoSave.nvim'
    Plug 'tpope/vim-surround'
    Plug 'junegunn/fzf.vim'

    " feature additions
    Plug 'nvim-telescope/telescope.nvim'
    Plug 'kyazdani42/nvim-tree.lua' " file explorer 
    Plug 'ahmedkhalf/project.nvim' " Project management (cds to file dir)
    Plug 'nvim-lua/plenary.nvim'
    Plug 'ellisonleao/glow.nvim' " markdown reader in nvim buffer
    Plug 'numtostr/FTerm.nvim'

    " editing
   Plug 'ZSaberLv0/ZFVimTxtHighlight'
    Plug 's1n7ax/nvim-comment-frame'
    Plug 'junegunn/vim-easy-align'
    Plug 'sheerun/vim-polyglot'

    " languages
    Plug 'mhartington/nvim-typescript'
    Plug 'ekalinin/dockerfile.vim'
    Plug 'chr4/nginx.vim'
    Plug 'lervag/vimtex'
    Plug 'fatih/vim-go'

    " utilities
    Plug 'lambdalisue/suda.vim'
    Plug 'folke/which-key.nvim'
    Plug 'mhinz/vim-startify'

    " nvim-cmp recommended configuration
    Plug 'neovim/nvim-lspconfig'
    Plug 'hrsh7th/cmp-nvim-lsp'
    Plug 'hrsh7th/cmp-buffer'
    Plug 'hrsh7th/nvim-cmp'

call plug#end()

" Lua
lua require ('plugins')
