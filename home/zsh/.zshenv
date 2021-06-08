# ~/.zshenv
# Environment variables configuration
# Always read

# Set ZSH config root to home (which is the default)
ZDOTDIR="$HOME"
ZCONFDIR="$ZDOTDIR/.zsh"
CONFDIR="${XDG_CONFIG_HOME:-$HOME/.config}"

export LANG\='en_US.UTF-8'
export LC_ALL\="en_US.UTF-8"
export TERM\=xterm-256color

# Environment
emulate sh -c '[ -f "$HOME/.envrc" ] && source "$HOME/.envrc"; source "$HOME/.profile"'

typeset -U PATH path
path=("$path[@]" "$paths[@]")
export PATH
