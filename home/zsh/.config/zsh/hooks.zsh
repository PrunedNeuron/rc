# ZSH hooks

# Load precmd hooks
source <(cat $(ls -1 $ZCONFDIR/hooks.d/precmd/*.zsh))

# Load chpwd hooks
# Disabled atm - use cdr built-in instead
# source <(cat $(ls -1 $ZCONFDIR/hooks.d/chpwd/*.zsh))

# Load other hooks
source <(cat $(ls -1 $ZCONFDIR/hooks.d/other/*.zsh))

# Searches for command if it is not found
# source /usr/share/doc/pkgfile/command-not-found.zsh
