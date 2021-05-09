# ~/.zshenv
# Environment variables configuration
# Always read

# Set ZSH config root to home (which is the default)
ZDOTDIR="$HOME"
ZCONFDIR="$ZDOTDIR/.zsh"
CONFDIR="${XDG_CONFIG_HOME:-$HOME/.config}"

# Environment
emulate sh -c '[ -f "$HOME/.envrc" ] && source "$HOME/.envrc"; source "$HOME/.profile"'

typeset -U PATH path
path=("$path[@]" "$paths[@]")
export PATH
