" nvim configuration

" plugins (using vim-plug as the plugin manager)
call plug#begin()

    " telescope.nvim
    Plug 'nvim-lua/popup.nvim'
    Plug 'nvim-lua/plenary.nvim'
    Plug 'nvim-telescope/telescope.nvim'

    " nvim-treesitter
    Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}

	  " directory tree
    Plug 'preservim/nerdtree'

    " ale
    Plug 'dense-analysis/ale'

    " neoformat
    Plug 'sbdchd/neoformat'

    " ayu color scheme
    Plug 'ayu-theme/ayu-vim'

    " material color scheme
    Plug 'kaicataldo/material.vim', { 'branch': 'main' }

    " vim-one color scheme
    Plug 'rakr/vim-one'

    " xcode color scheme
    Plug 'arzg/vim-colors-xcode'

    " lightline
    Plug 'itchyny/lightline.vim'

	  " fuzzy finder
    Plug 'junegunn/fzf'

    " completion
    Plug 'valloric/youcompleteme'

    " syntax
    Plug 'sheerun/vim-polyglot'

    " parantheses, braces, etc
    Plug 'tpope/vim-surround'

    " git
    Plug 'tpope/vim-fugitive'

    " golang
    Plug 'fatih/vim-go'

    " typescript
    Plug 'mhartington/nvim-typescript'

    " dockerfile
    Plug 'ekalinin/dockerfile.vim'

    " nginx
    Plug 'chr4/nginx.vim'

	  " startify
	  Plug 'mhinz/vim-startify'

    " vimtex - for LaTeX
    Plug 'lervag/vimtex'
    
    " telescope
    Plug 'nvim-telescope/telescope.nvim'
    
    " Plaintext files highlight
    Plug 'ZSaberLv0/ZFVimTxtHighlight'
    
    " Web Devicons
    Plug 'kyazdani42/nvim-web-devicons'
    
    " nonicons
    Plug 'yamatsum/nvim-nonicons'

    " vim-pencil
    Plug 'reedes/vim-pencil'

    " neomake
    Plug 'neomake/neomake'

    " neoscroll smooth scroll
    Plug 'karb94/neoscroll.nvim'

    " autosave
    Plug 'Pocco81/AutoSave.nvim'

    " read/write with sudo privileges
    Plug 'lambdalisue/suda.vim'

    " nvim-colorizer
    Plug 'norcalli/nvim-colorizer.lua'

	" signify
	if has('nvim') || has('patch-8.0.902')
		Plug 'mhinz/vim-signify'
	else
		Plug 'mhinz/vim-signify', { 'branch': 'legacy' }
	endif

call plug#end()

" UI Config {{{
set hidden
set title					 " set terminal title to file name
set number                   " show line number
set showcmd                  " show command in bottom bar
set wildmenu                 " visual autocomplete for command menu
set showmatch                " highlight matching brace
set laststatus=2             " window will always have a status line
" }}} UI Config

" Clipboard {{{
set clipboard+=unnamedplus
" }}} Clipboard

" Spaces & Tabs {{{
set tabstop=4       " number of visual spaces per TAB
set softtabstop=4   " number of spaces in tab when editing
set shiftwidth=4    " number of spaces to use for autoindent
set expandtab       " tabs are space
set autoindent
set copyindent      " copy indent from the previous line
filetype indent plugin on
" }}} Spaces & Tabs

" Search {{{
set incsearch       " search as characters are entered
set hlsearch        " highlight matche
set ignorecase      " ignore case when searching
set smartcase       " ignore case if search pattern is lower case
                    " case-sensitive otherwise
" }}} Search

" Graphics {{{
set termguicolors			 " enable true color support
syntax enable                " enable syntax processing
"let ayucolor="light"
colorscheme xcodelight

" set lightline theme
let g:lightline = {
      \ 'colorscheme': 'ayu_light',
      \ }
" }}} Graphics

" Behavior {{{
set notimeout				 " Remove timeout for partially typed commands
set mouse=a					 " allow the mouse in all cases
set formatoptions-=cro		 " disable comment continuation
" }}} Behavior

" set signify's async update interval (in ms)
set updatetime=100

" setup function with require
lua require('neoscroll').setup()

lua << EOF
local autosave = require("autosave")

autosave.setup(
    {
        enabled = true,
        execution_message = "AutoSave: saved at " .. vim.fn.strftime("%H:%M:%S"),
        events = {"InsertLeave", "TextChanged"},
        conditions = {
            exists = true,
            filetype_is_not = {},
            modifiable = true
        },
        write_all_buffers = false,
        on_off_commands = true,
        clean_command_line_interval = 0,
        debounce_delay = 135
    }
)
EOF

