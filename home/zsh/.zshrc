# ~/.zshrc
# Interactive shell configuration
# Read when starting as an interactive shell

# Run initial checks and repair
source $ZCONFDIR/other/pre.zsh

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

# Bind keys
source $ZCONFDIR/keybindings.zsh

# Load plugins
source $ZCONFDIR/plugins.zsh

# Run final checks
source $ZCONFDIR/other/post.zsh

export PATH="/home/ayush/.deta/bin:$PATH"

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/usr/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/usr/etc/profile.d/conda.sh" ]; then
        . "/usr/etc/profile.d/conda.sh"
    else
        export PATH="/usr/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<

