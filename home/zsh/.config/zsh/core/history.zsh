# core/history.zsh — History file location and size limits.

HISTFILE="$ZDATADIR/.zhistory"
SAVEHIST=$(( 100 * 1000 ))
# zsh recommends HISTSIZE > SAVEHIST to accommodate in-memory entries that
# haven't been flushed yet (the 1.2× factor is the upstream recommendation).
HISTSIZE=$(( 120 * 1000 ))