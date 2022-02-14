# ~/.zshrc
# Interactive shell configuration
# Read when starting as an interactive shell

# Run initial checks and repair
source $ZCONFDIR/pre.zsh

# Configure history
source $ZCONFDIR/other/history.zsh

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
