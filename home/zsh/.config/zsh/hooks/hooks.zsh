# hooks/hooks.zsh — Source all precmd and preexec hook files.
for _f in "$ZCONFDIR"/hooks/precmd/*.zsh(.N); do source "$_f"; done
unset _f
# preexec/ is reserved for future hooks; add an analogous loop if needed.