-- ~/.config/nvim/init.lua

-- bootstrap lazy.nvim, LazyVim and your plugins
require("config.lazy")

-- Additional DokuVimKi configuration
vim.cmd([[
" looks for DokuWiki headlines in the first 20 lines
" of the current buffer
fun IsDokuWiki()
  if match(getline(1,20),'^ \=\(=\{2,6}\).\+\1 *$') >= 0
    set textwidth=0
    set wrap
    set linebreak
    set filetype=dokuwiki
  endif
endfun

" check for dokuwiki syntax
autocmd BufWinEnter *.txt call IsDokuWiki()

syntax on
]])
