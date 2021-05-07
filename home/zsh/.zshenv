# ~/.zshenv

emulate sh -c '[ -f ~/.envrc ] && source ~/.envrc'

# Set ZSH config root to home (which is the default)
ZDOTDIR="$HOME"
ZCONFDIR="$ZDOTDIR/.zsh"

typeset -U PATH path
path=("$path[@]" "$paths[@]")
export PATH
