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
set tabstop=4       " number of visual spaces per TAB
set expandtab       " tabs are space
set copyindent      " copy indent from the previous line

" search
set ignorecase      " ignore case when searching
set incsearch       " search as characters are entered
set smartcase       " ignore case if search pattern is lower case, case-sensitive otherwise
set hlsearch        " highlight matche

" graphics
set termguicolors			 " enable true color support
syntax enable                " enable syntax processing

" completion
set completeopt=menu,menuone,noselect

" behavior
set notimeout				 " Remove timeout for partially typed commands
set mouse=a					 " allow the mouse in all cases

" custom
set ww+=<,>                  " make the left and right movement wrap to previous/next line

" set signify's async update interval (in ms)
set updatetime=100

