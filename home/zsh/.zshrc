# .zshrc


# Return if the shell is not interactive
case $- in (*i*) ;; (*) return ;; esac

# Return if the shell is a login shell
case $- in (*l*) return ;; (*) ;; esac

# Profile startup time metrics
PROFILE_STARTUP=${PROFILE_STARTUP:-false}
if $PROFILE_STARTUP; then
    zmodload zsh/zprof
    # http://zsh.sourceforge.net/Doc/Release/Prompt-Expansion.html
    PS4=$'%D{%M%S%.} %N:%i> '
    exec 3>&2 2>$HOME/startlog.$$
    setopt xtrace prompt_subst
fi

autoload -Uz compinit; compinit
autoload -U promptinit; promptinit
autoload -Uz url-quote-magic
zle -N self-insert url-quote-magic
autoload -Uz add-zsh-hook

source ~/.zsh/hooks.zsh
add-zsh-hook -Uz precmd rehash_precmd

# History
HISTFILE=~/.zhistory
HISTFILESIZE=50000
HISTSIZE=100000
SAVEHIST=$HISTSIZE

## Source all at once?
## source <(cat $(ls -1 ~/.zsh/*.zsh))

# ZSH options
source ~/.zsh/options.zsh

# Load plugins
source <(antibody init) # Initialize antibody
antibody bundle < ~/.zsh/plugins.zsh

source ~/.zsh/bindkeys.zsh
source ~/.zsh/prompt.zsh
source ~/.zsh/functions.zsh

# Source .rcs
source ~/.pathrc
source ~/.aliasrc

# End profiling
if $PROFILE_STARTUP; then
    unsetopt xtrace
    exec 2>&3 3>&-
    zprof > ~/zshprofile$(date +'%s')
fi
