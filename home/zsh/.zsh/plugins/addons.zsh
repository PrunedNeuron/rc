# Plugins that improve the overall ZSH experience

# History search by substring
zinit ice wait lucid
zinit light zsh-users/zsh-history-substring-search

# Autosuggestions & fast-syntax-highlighting
zinit wait lucid light-mode for \
    atinit"ZINIT[COMPINIT_OPTS]=-C; zpcompinit; zpcdreplay" \
        zdharma/fast-syntax-highlighting \
    atload"!_zsh_autosuggest_start" \
        zsh-users/zsh-autosuggestions \
        zsh-users/zsh-completions \
        # marlonrichert/zsh-autocomplete

# Fuzzy finder
zinit has'fzf' lucid light-mode for \
    atload"export \
            FZF_DEFAULT_COMMAND='fd --type f --hidden --follow --exclude .git' \
            FZF_DEFAULT_OPTS='
                --height 40% --layout=reverse --border
                --color=bg+:#D9D9D9,bg:#FFFFFF,border:#C8C8C8,spinner:#719899,hl:#719872
                --color=fg:#616161,header:#719872,info:#727100,pointer:#E12672
                --color=marker:#E17899,fg+:#616161,preview-bg:#D9D9D9,prompt:#0099BD,hl+:#719899'" \
        unixorn/fzf-zsh-plugin \
        Aloxaf/fzf-tab

# fm file manager
zinit ice --depth'1' atinit'source fm.zsh' atclone'./fm__compile' atpull'%atclone'
zinit light ddnexus/fm

# Git extras
zinit lucid wait'0a' for \
    as"program" pick"$ZPFX/bin/git-*" src"etc/git-extras-completion.zsh" make"PREFIX=$ZPFX" \
        tj/git-extras
