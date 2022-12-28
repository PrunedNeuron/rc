# ~/.zsh/plugins.zsh
# zsh plugins, managed with zinit

source <(cat $(ls -1 $ZCONFDIR/plugins.d/*.zsh))
