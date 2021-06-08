# Plugins that improve the overall ZSH experience

# Fast-syntax-highlighting
zinit wait"0c" lucid light-mode for \
    atinit"ZINIT[COMPINIT_OPTS]=-C; zpcompinit; zpcdreplay" \
        zdharma/fast-syntax-highlighting

# Autosuggestions & basic completions
zinit wait"0a" lucid light-mode for \
    atload"!_zsh_autosuggest_start" \
        zsh-users/zsh-autosuggestions \
        zsh-users/zsh-completions \
        zsh-users/zsh-history-substring-search \
        marlonrichert/zsh-autocomplete ## Breaks fzf partially

# Fuzzy finder
zinit has'fzf' lucid light-mode for \
    atload'source "$HOME/.config/fzf/config"' \
        unixorn/fzf-zsh-plugin
#         Aloxaf/fzf-tab

# fm file manager
zinit ice --depth'1' atinit'source fm.zsh' atclone'./fm__compile' atpull'%atclone'
zinit light ddnexus/fm

# Git extras
zinit lucid wait'0a' for \
    as"program" pick"$ZPFX/bin/git-*" src"etc/git-extras-completion.zsh" make"PREFIX=$ZPFX" \
        tj/git-extras
