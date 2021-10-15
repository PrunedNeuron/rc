" nvim configuration

" plugins (using vim-plug as the plugin manager)
call plug#begin()

	" colorschemes
    Plug 'kaicataldo/material.vim', { 'branch': 'main' }
    Plug 'arzg/vim-colors-xcode'
    Plug 'yous/vim-open-color'
    Plug 'kjssad/quantum.vim'
    Plug 'ayu-theme/ayu-vim'
    Plug 'rakr/vim-one'

	" graphics
    Plug 'kyazdani42/nvim-web-devicons'
    Plug 'norcalli/nvim-colorizer.lua'
    Plug 'yamatsum/nvim-nonicons'
    Plug 'karb94/neoscroll.nvim'
    Plug 'itchyny/lightline.vim'
    Plug 'folke/twilight.nvim'

	" enhancements
	Plug 'neoclide/coc.nvim', {'branch': 'release'}
    Plug 'nvim-telescope/telescope.nvim'
    Plug 'Xuyuanp/nerdtree-git-plugin'
    Plug 'terrortylor/nvim-comment'
    Plug 'neovim/nvim-lspconfig'
    Plug 'Pocco81/AutoSave.nvim'
    Plug 'lambdalisue/suda.vim'
    Plug 'nvim-lua/popup.nvim'
    Plug 'preservim/nerdtree'
    Plug 'dense-analysis/ale'
    Plug 'tpope/vim-surround'
    Plug 'mhinz/vim-startify'
    Plug 'tpope/vim-fugitive'
    Plug 'reedes/vim-pencil'
    Plug 'junegunn/fzf'

    " editing
    Plug 'ZSaberLv0/ZFVimTxtHighlight'
    Plug 'junegunn/vim-easy-align'
    Plug 'valloric/youcompleteme'
    Plug 'sheerun/vim-polyglot'
    Plug 'godlygeek/tabular'
    Plug 'sbdchd/neoformat'

    " languages
    Plug 'mhartington/nvim-typescript'
    Plug 'ekalinin/dockerfile.vim'
    Plug 'chr4/nginx.vim'
    Plug 'lervag/vimtex'
    Plug 'fatih/vim-go'

    " git
    Plug 'f-person/git-blame.nvim'

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
set laststatus=2             " window will always have a status line
set showmatch                " highlight matching brace
set wildmenu                 " visual autocomplete for command menu
set showcmd                  " show command in bottom bar
set hidden
set number                   " show line number
set title					 " set terminal title to file name

" clipboard
set clipboard+=unnamedplus

" spaces & tabs
set softtabstop=4   " number of spaces in tab when editing
set shiftwidth=4    " number of spaces to use for autoindent
set autoindent      " autoindent
set copyindent      " copy indent from the previous line
set tabstop=4       " number of visual spaces per TAB
set expandtab       " tabs are space

" search
set ignorecase      " ignore case when searching
set incsearch       " search as characters are entered
set smartcase       " ignore case if search pattern is lower case, case-sensitive otherwise
set hlsearch        " highlight matche

" graphics
set termguicolors			 " enable true color support
syntax enable                " enable syntax processing

" set colorscheme
set background=light
colorscheme one

" behavior
set formatoptions-=cro		 " disable comment continuation
set notimeout				 " Remove timeout for partially typed commands
set mouse=a					 " allow the mouse in all cases

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

" gitblame
let g:gitblame_enabled = 0

" Mappings
" Start interactive EasyAlign in visual mode (e.g. vipga)
xmap ga <Plug>(EasyAlign)

" Start interactive EasyAlign for a motion/text object (e.g. gaip)
nmap ga <Plug>(EasyAlign)

" Lua
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
