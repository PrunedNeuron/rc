# ~/.zshrc
# Interactive shell configuration
# Read when starting as an interactive shell

# Run initial checks and repair
source $ZCONFDIR/preinit.zsh

# History configuration
HISTFILE=$HOME/.zhistory
SAVEHIST=$(( 100 * 1000 ))
HISTSIZE=$(( 1.2 * SAVEHIST )) # ZSH recommended value

# Common shell config
emulate bash -c 'source <(cat $(ls -1 $CONFDIR/shell/**/*))'

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

# Load extras
autoload -Uz url-quote-magic
zle -N self-insert url-quote-magic
