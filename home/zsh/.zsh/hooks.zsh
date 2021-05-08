# ZSH hooks

# Load precmd hooks
source <(cat $(ls -1 $ZCONFDIR/hooks/precmd/*.zsh))

# Load chpwd hooks
# Disabled atm - use cdr built-in instead
# source <(cat $(ls -1 $ZCONFDIR/hooks/chpwd/*.zsh))
