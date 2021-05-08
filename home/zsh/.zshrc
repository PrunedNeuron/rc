# ~/.zshrc
# Interactive shell configuration
# Read when starting as an interactive shell

source $ZCONFDIR/preinit.zsh

autoload -Uz compinit; compinit
autoload -U promptinit; promptinit
autoload -Uz url-quote-magic

zle -N self-insert url-quote-magic

# Load ZSH hooks
source $ZCONFDIR/hooks.zsh

# History configuration
HISTFILE=$HOME/.zhistory
SAVEHIST=$(( 100 * 1000 ))
HISTSIZE=$(( 1.2 * SAVEHIST )) # ZSH recommended value

# ZSH options (setopts)
source $ZCONFDIR/options.zsh

# ZSH styles (zstyles)
source $ZCONFDIR/styles.zsh

# Load custom functions
source $ZCONFDIR/functions.zsh

# Load plugins
source $ZCONFDIR/plugins.zsh

# Bind keys
source $ZCONFDIR/keybindings.zsh

# Other RCs
source ~/.aliasrc
