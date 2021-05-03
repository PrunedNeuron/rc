[ -f ~/.profile ] && source ~/.profile
[ -f ~/.pathrc ] && source ~/.pathrc 

typeset -U PATH path
path=("$path[@]" "$paths[@]")
export PATH
