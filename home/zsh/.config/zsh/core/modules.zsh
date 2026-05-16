# core/modules.zsh — zsh built-in module loading.
# Must run before compinit (triggered by 'zmodule completion' in ZIM_HOME/init.zsh).

# complist: provides the menuselect keymap — required by fzf-tab
zmodload zsh/complist

# datetime: $EPOCHSECONDS (int) + $EPOCHREALTIME (float)
# Used for zero-fork mtime comparisons in _cached_eval and precmd hooks.
zmodload zsh/datetime

# stat: zstat builtin — file metadata without forking stat(1)
zmodload -F zsh/stat b:zstat

# terminfo: echoti — used in keybindings for smkx/rmkx application-mode entry
zmodload zsh/terminfo