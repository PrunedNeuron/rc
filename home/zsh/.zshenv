# ~/.zshenv
# Environment variables configuration
# Always read

# User configuration directory
CONFDIR="${XDG_CONFIG_HOME:-$HOME/.config}"
CACHEDIR="${XDG_CACHE_DIR:-$HOME/.cache}"
DATADIR="${XDG_DATA_DIR:-$HOME/.local/share}"

# Set ZSH config root to home (which is the default)
ZDOTDIR="$HOME"
ZCONFDIR="$CONFDIR/zsh"
ZCACHEDIR="$CACHEDIR/zsh"
ZDATADIR="$DATADIR/zsh"

export LANG="en_US.UTF-8"
export LC_ALL="en_US.UTF-8"

# Environment
emulate sh -c \
    '[ -f "$HOME/.envrc" ] \
    && source "$HOME/.envrc" \
    && source "$HOME/.profile"'

typeset -U PATH path
path=("$path[@]" "$paths[@]")
export PATH
