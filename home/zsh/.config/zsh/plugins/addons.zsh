# Plugins that improve the overall ZSH experience

zinit wait lucid light-mode for \
    atinit"ZINIT[OPTIMIZE_OUT_DISK_ACCESSES]=1;
            ZINIT[COMPINIT_OPTS]=-C;
            ZINIT[ZCOMPDUMP_PATH]=$ZCACHEDIR/.zcompdump;
            zpcompinit; zpcdreplay" \
        zdharma/fast-syntax-highlighting \
    atload"!_zsh_autosuggest_start" \
        zsh-users/zsh-autosuggestions \
    blockf atpull'zinit creinstall -q .' \
        zsh-users/zsh-completions

# Real time autocomplete
zinit light marlonrichert/zsh-autocomplete

# History substring search
zinit ice wait"1" lucid
zinit light zsh-users/zsh-history-substring-search
