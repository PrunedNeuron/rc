# $zshrc

source $ZCONFDIR/preinit.zsh

autoload -Uz compinit; compinit
autoload -U promptinit; promptinit
autoload -Uz url-quote-magic
zle -N self-insert url-quote-magic
autoload -Uz add-zsh-hook

source $ZCONFDIR/hooks.zsh
add-zsh-hook -Uz precmd rehash_precmd

# History
HISTFILE=~/.zhistory
HISTFILESIZE=50000
HISTSIZE=100000
SAVEHIST=$HISTSIZE

## Source all at once?
## source <(cat $(ls -1 $ZCONFDIR/*.zsh))

# ZSH options
source $ZCONFDIR/options.zsh

# Load plugins
# source <(antibody init) # Initialize antibody
# antibody bundle < $ZCONFDIR/plugins.zsh

source $ZCONFDIR/prompt.zsh
source $ZCONFDIR/functions.zsh

# Other RCs
source ~/.aliasrc

# Load plugins
source $ZCONFDIR/plugins.zsh
source $ZCONFDIR/bindkeys.zsh
