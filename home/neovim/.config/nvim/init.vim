" nvim configuration

" Source plugins
source ~/.config/nvim/plugins.vim
source ~/.config/nvim/options.vim

" colorschemes
"" vim-one 
set background=light
colorscheme one

"" ayu-vim
" let ayucolor="light" " ['light', 'mirage', 'dark']
" colorscheme ayu


" abbreviations / aliases
cnoreabbrev sw SudaWrite

" Mappings
" Start interactive EasyAlign in visual mode (e.g. vipga)
xmap ga <Plug>(EasyAlign)

" Start interactive EasyAlign for a motion/text object (e.g. gaip)
nmap ga <Plug>(EasyAlign)

" remap clipboard commands to use sys clipboard
noremap <Leader>y "*y
noremap <Leader>p "*p
noremap <Leader>Y "+y
noremap <Leader>P "+p

" Lua
lua require('plugins')

