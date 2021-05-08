# Plugins that improve the overall ZSH experience

## Essentials

# Autosuggestions & fast-syntax-highlighting
zinit wait lucid light-mode for \
    atinit"ZINIT[COMPINIT_OPTS]=-C; zpcompinit; zpcdreplay" \
        zdharma/fast-syntax-highlighting \
    atload"!_zsh_autosuggest_start" \
        zsh-users/zsh-autosuggestions \
        marlonrichert/zsh-autocomplete # Amazing!

zinit light ael-code/zsh-colored-man-pages
zinit light zsh-users/zsh-history-substring-search
zinit light zsh-users/zsh-completions

# zsh-autopair (Auto-close and delete matching delimiters)
zinit light hlissner/zsh-autopair

# zsh-you-should-use (Recommends aliases that you could have used)
zinit ice wait lucid
zinit load MichaelAquilina/zsh-you-should-use

# Gitignore plugin – commands gii and gi
zinit ice wait"2" lucid
zinit load voronkovich/gitignore.plugin.zsh
