# Plugins that improve the overall ZSH experience

zinit light marlonrichert/zsh-autocomplete

zinit ice wait"2" lucid
zinit light zsh-users/zsh-history-substring-search

zinit wait"1" lucid light-mode for \
    atinit"ZINIT[OPTIMIZE_OUT_DISK_ACCESSES]=1;
            ZINIT[COMPINIT_OPTS]=-C;
            ZINIT[ZCOMPDUMP_PATH]=$ZCACHEDIR/.zcompdump;
            zpcompinit; zpcdreplay" \
        zdharma-continuum/fast-syntax-highlighting \
    atload"!_zsh_autosuggest_start" \
        zsh-users/zsh-autosuggestions \
    blockf atpull'zinit creinstall -q .' \
        zsh-users/zsh-completions
