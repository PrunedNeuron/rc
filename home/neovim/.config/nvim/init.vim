" nvim configuration

" plugins (using vim-plug as the plugin manager)
call plug#begin()

	" colorschemes
    Plug 'ayu-theme/ayu-vim'
    Plug 'rakr/vim-one'
    Plug 'arzg/vim-colors-xcode'
    Plug 'yous/vim-open-color'
    Plug 'kjssad/quantum.vim'
    Plug 'kaicataldo/material.vim', { 'branch': 'main' }

	" graphics
    Plug 'norcalli/nvim-colorizer.lua'
    Plug 'kyazdani42/nvim-web-devicons'
    Plug 'yamatsum/nvim-nonicons'
    Plug 'karb94/neoscroll.nvim'
    Plug 'itchyny/lightline.vim'
    Plug 'folke/twilight.nvim'

	" enhancements
	Plug 'neoclide/coc.nvim', {'branch': 'release'}
    Plug 'nvim-telescope/telescope.nvim'
    Plug 'Xuyuanp/nerdtree-git-plugin'
    Plug 'preservim/nerdtree'
    Plug 'dense-analysis/ale'
    Plug 'nvim-lua/popup.nvim'
    Plug 'Pocco81/AutoSave.nvim'
    Plug 'neovim/nvim-lspconfig'
    Plug 'lambdalisue/suda.vim'
    Plug 'b3nj5m1n/kommentary'
    Plug 'tpope/vim-surround'
    Plug 'tpope/vim-fugitive'
    Plug 'mhinz/vim-startify'
    Plug 'reedes/vim-pencil'
    Plug 'junegunn/fzf'

    " editing
    Plug 'valloric/youcompleteme'
    Plug 'sbdchd/neoformat'
    Plug 'sheerun/vim-polyglot'
    Plug 'ZSaberLv0/ZFVimTxtHighlight'

    " languages
    Plug 'fatih/vim-go'
    Plug 'mhartington/nvim-typescript'
    Plug 'ekalinin/dockerfile.vim'
    Plug 'chr4/nginx.vim'
    Plug 'lervag/vimtex'

    " tooling
    Plug 'neomake/neomake'

	" signify
	if has('nvim') || has('patch-8.0.902')
		Plug 'mhinz/vim-signify'
	else
		Plug 'mhinz/vim-signify', { 'branch': 'legacy' }
	endif

call plug#end()

" ui config
set hidden
set title					 " set terminal title to file name
set number                   " show line number
set showcmd                  " show command in bottom bar
set wildmenu                 " visual autocomplete for command menu
set showmatch                " highlight matching brace
set laststatus=2             " window will always have a status line

" clipboard
set clipboard+=unnamedplus

" spaces & tabs
set tabstop=4       " number of visual spaces per TAB
set softtabstop=4   " number of spaces in tab when editing
set shiftwidth=4    " number of spaces to use for autoindent
set expandtab       " tabs are space
set autoindent
set copyindent      " copy indent from the previous line

" search
set incsearch       " search as characters are entered
set hlsearch        " highlight matche
set ignorecase      " ignore case when searching
set smartcase       " ignore case if search pattern is lower case
                    " case-sensitive otherwise

" graphics
set termguicolors			 " enable true color support
syntax enable                " enable syntax processing

" set colorscheme
colorscheme one
set background=light

" behavior
set notimeout				 " Remove timeout for partially typed commands
set mouse=a					 " allow the mouse in all cases
set formatoptions-=cro		 " disable comment continuation

" custom
set ww+=<,>                  " make the left and right movement wrap to previous/next line

" abbreviations / aliases
cnoreabbrev sw SudaWrite

" options
let NERDTreeShowHidden=1

" set lightline theme
let g:lightline = {
      \ 'colorscheme': 'ayu_light',
      \ }

" set signify's async update interval (in ms)
set updatetime=100

" setup function with require
lua require('neoscroll').setup()

lua << EOF

-- Autosave
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
