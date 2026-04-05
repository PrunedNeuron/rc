# ~/.zshenv
# sourced for every shell (interactive, non-interactive, scripts)

# XDG Base Directories
CONFDIR="${XDG_CONFIG_HOME:-$HOME/.config}"
CACHEDIR="${XDG_CACHE_HOME:-$HOME/.cache}"
DATADIR="${XDG_DATA_HOME:-$HOME/.local/share}"

ZDOTDIR="$HOME"
ZCONFDIR="$CONFDIR/zsh"
ZCACHEDIR="$CACHEDIR/zsh"
ZDATADIR="$DATADIR/zsh"

export LANG="en_US.UTF-8"
export LC_ALL="en_US.UTF-8"

# Load POSIX env files; keep them separate so profile loads unconditionally
emulate sh -c '[ -f "$HOME/.envrc"   ] && source "$HOME/.envrc"'
# emulate sh -c '[ -f "$HOME/.profile" ] && source "$HOME/.profile"'

# Deduplicate PATH (no $paths — was undefined, harmless but noisy)
typeset -gU PATH path
export PATH
