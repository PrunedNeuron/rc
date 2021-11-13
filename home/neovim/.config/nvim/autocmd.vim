" autocmd commands

" cd to current file's directory unless it is in /tmp
autocmd BufEnter * if expand("%:p:h") !~ '^/tmp' | silent! lcd %:p:h | endif

" disable comment continuation
autocmd FileType * setlocal formatoptions-=cro

