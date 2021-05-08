# Plugins that improve the overall ZSH experience

## Essentials

# Autosuggestions & fast-syntax-highlighting
zinit ice wait lucid atinit"ZINIT[COMPINIT_OPTS]=-C; zpcompinit; zpcdreplay"
zinit light zdharma/fast-syntax-highlighting

# zsh-autosuggestions
zinit ice wait lucid atload"!_zsh_autosuggest_start"
zinit load zsh-users/zsh-autosuggestions

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
