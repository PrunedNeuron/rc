# $ZCONFDIR/hooks.zsh
# Sources all precmd hook files. Glob loop — no subshell forks.

for _f in $ZCONFDIR/hooks.d/precmd/*.zsh(.N); do source "$_f"; done; unset _f
