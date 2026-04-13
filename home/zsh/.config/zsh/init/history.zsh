# $ZCONFDIR/init/history.zsh

HISTFILE="$ZDATADIR/.zhistory"
SAVEHIST=$(( 100 * 1000 ))
HISTSIZE=$(( 1.2 * SAVEHIST ))   # zsh recommends HISTSIZE > SAVEHIST
