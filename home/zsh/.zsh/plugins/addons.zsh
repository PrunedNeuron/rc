# Plugins that improve the overall ZSH experience

# Autosuggestions & fast-syntax-highlighting
zinit wait lucid light-mode for \
    marlonrichert/zsh-autocomplete \
    atinit"ZINIT[COMPINIT_OPTS]=-C; zpcompinit; zpcdreplay" \
        zdharma/fast-syntax-highlighting \
    atload"!_zsh_autosuggest_start" \
        zsh-users/zsh-autosuggestions \
        zsh-users/zsh-completions

# History and real time autocomplete
zinit light zsh-users/zsh-history-substring-search

# zsh-autopair (Auto-close and delete matching delimiters)
zinit light hlissner/zsh-autopair

# Git extras
zinit lucid wait'0a' for \
as"program" pick"$ZPFX/bin/git-*" src"etc/git-extras-completion.zsh" make"PREFIX=$ZPFX" tj/git-extras
