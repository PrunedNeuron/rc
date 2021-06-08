" vim/nvim configuration

set termguicolors
filetype indent plugin on
syntax on

" vim-plug
call plug#begin()

	" directory tree
    Plug 'preservim/nerdtree'

    " ayu color scheme
    Plug 'ayu-theme/ayu-vim'

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

    " airline
    Plug 'vim-airline/vim-airline'
	Plug 'vim-airline/vim-airline-themes'
	
	" startify
	Plug 'mhinz/vim-startify'
	
	" signify
	if has('nvim') || has('patch-8.0.902')
		Plug 'mhinz/vim-signify'
	else
		Plug 'mhinz/vim-signify', { 'branch': 'legacy' }
	endif

call plug#end()

let ayucolor="light"
colorscheme ayu

" set airline theme
let g:airline_theme='light'

" set signify's async update interval (in ms)
set updatetime=100
