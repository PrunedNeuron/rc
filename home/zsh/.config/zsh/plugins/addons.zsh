# Plugins that improve the overall ZSH experience

zinit lucid light-mode for \
    atinit"ZINIT[OPTIMIZE_OUT_DISK_ACCESSES]=1;
            ZINIT[COMPINIT_OPTS]=-C;
            ZINIT[ZCOMPDUMP_PATH]=$ZCACHEDIR/.zcompdump;
            zpcompinit; zpcdreplay" \
        zdharma-continuum/fast-syntax-highlighting \
        zsh-users/zsh-history-substring-search \
    atload"!_zsh_autosuggest_start" \
        zsh-users/zsh-autosuggestions \
    blockf atpull"zinit creinstall -q ." \
        zsh-users/zsh-completions

# marlonrichert/zsh-autocomplete \
