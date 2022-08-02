# Plugins that improve the overall ZSH experience

zi wait lucid light-mode for \
    atinit'mkdir -p $ZCACHEDIR;
            ZINIT[HOME_DIR]=$ZDATADIR/zinit;
            ZINIT[ZCOMPDUMP_PATH]=$ZCACHEDIR/.zcompdump;
            ZINIT[OPTIMIZE_OUT_DISK_ACCESSES]=1;
            ZINIT[COMPINIT_OPTS]=-C;
            zicompinit; zicdreplay' \
        zdharma-continuum/fast-syntax-highlighting \
        zdharma-continuum/history-search-multi-word \
    atload'!_zsh_autosuggest_start' \
        zsh-users/zsh-autosuggestions \
    blockf atpull'zinit creinstall -q .' \
        zsh-users/zsh-completions

