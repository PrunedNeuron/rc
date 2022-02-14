# ~/.zshenv
# Environment variables configuration
# Always read

# User configuration directory
CONFDIR="${XDG_CONFIG_HOME:-$HOME/.config}"
CACHEDIR="${XDG_CACHE_DIR:-$HOME/.cache}"

# Set ZSH config root to home (which is the default)
ZDOTDIR="$HOME"
ZCONFDIR="$CONFDIR/zsh"
ZCACHEDIR="$CACHEDIR/zsh"

export LANG\="en_US.UTF-8"
export LC_ALL\="en_US.UTF-8"
export TERM\=xterm-256color

# Colorize man pages using less as the pager
# export MANPAGER="sh -c \"col -b | nvim -c 'set ft=man ts=8 nomod nolist nonu' -c 'nnoremap i <nop>' -\""
# export MANPAGER="less -R --use-color -Dd+r -Du+b"
export MANPAGER="moar"

# Environment
emulate sh -c '[ -f "$HOME/.envrc" ] && source "$HOME/.envrc"; source "$HOME/.profile"'

typeset -U PATH path
path=("$path[@]" "$paths[@]")
export PATH
