# Plugins that improve the overall ZSH experience

# Fast-syntax-highlighting
zinit wait"0c" lucid light-mode for \
    atinit"ZINIT[COMPINIT_OPTS]=-C; zpcompinit; zpcdreplay" \
        zdharma/fast-syntax-highlighting \
        marlonrichert/zsh-autocomplete # Instant autosuggestions - load instantly

# Autosuggestions & basic completions
zinit wait"0a" lucid light-mode for \
    atload"!_zsh_autosuggest_start" \
        zsh-users/zsh-autosuggestions \
        zsh-users/zsh-completions \
        zsh-users/zsh-history-substring-search

# fm file manager
zinit ice --depth'1' atinit'source fm.zsh' atclone'./fm__compile' atpull'%atclone'
zinit light ddnexus/fm

# zsh-fnm
zinit ice atinit"export ZSH_FNM_NODE_VERSION='16.4.0'"
zinit light "dominik-schwabe/zsh-fnm"
