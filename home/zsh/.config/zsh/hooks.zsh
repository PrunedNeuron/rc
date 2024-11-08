# $ZCONFDIR/hooks.zsh

# Load precmd hooks
source <(cat $(ls -1 $ZCONFDIR/hooks.d/precmd/*.zsh))
