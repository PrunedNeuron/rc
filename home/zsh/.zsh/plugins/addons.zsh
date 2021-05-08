# Plugins that improve the overall ZSH experience

# Autosuggestions & fast-syntax-highlighting
zinit wait lucid light-mode for \
    atinit"ZINIT[COMPINIT_OPTS]=-C; zpcompinit; zpcdreplay" \
        zdharma/fast-syntax-highlighting \
    atload"!_zsh_autosuggest_start" \
        zsh-users/zsh-autosuggestions \
        zsh-users/zsh-completions \
        marlonrichert/zsh-autocomplete

zinit light zsh-users/zsh-history-substring-search

# Git extras
zinit lucid wait'0a' for \
    as"program" pick"$ZPFX/bin/git-*" src"etc/git-extras-completion.zsh" make"PREFIX=$ZPFX" \
        tj/git-extras
