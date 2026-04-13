# $ZCONFDIR/zmods.zsh — built-in zsh module loading.
# Must run before compinit (triggered inside init/post.zsh via `zmodule completion`).

# complist: required for the menuselect keymap used by fzf-tab
zmodload zsh/complist

# mapfile: $mapfile associative array for reading files into variables
zmodload zsh/mapfile

# datetime: $EPOCHSECONDS (int) and $EPOCHREALTIME (float)
# Used in precmd hooks for zero-fork timestamp comparisons
zmodload zsh/datetime

# stat: zstat builtin for file metadata — no external stat(1) fork needed
zmodload -F zsh/stat b:zstat
