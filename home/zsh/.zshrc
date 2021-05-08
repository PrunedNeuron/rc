# ~/.zshrc

source $ZCONFDIR/preinit.zsh

autoload -Uz compinit; compinit
autoload -U promptinit; promptinit
autoload -Uz \
    cdr \
    chpwd_recent_dirs \
    add-zsh-hook \
    url-quote-magic
    
source $ZCONFDIR/hooks.zsh
add-zsh-hook chpwd chpwd_recent_dirs

zle -N self-insert url-quote-magic

# History
HISTFILE=~/.zhistory
SAVEHIST=$(( 100 * 1000 ))
HISTSIZE=$(( 1.2 * SAVEHIST )) # Zsh recommended value

# ZSH options (setopts)
source $ZCONFDIR/options.zsh

# ZSH styles (zstyles)
source $ZCONFDIR/styles.zsh

# Load custom functions
source $ZCONFDIR/functions.zsh

# Other RCs
source ~/.aliasrc

# Load plugins
source $ZCONFDIR/plugins.zsh
source $ZCONFDIR/keybindings.zsh
