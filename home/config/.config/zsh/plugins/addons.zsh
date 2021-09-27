# Plugins that improve the overall ZSH experience

# a. Autosuggestions
zinit wait"0a" lucid light-mode for \
    atload"!_zsh_autosuggest_start" \
        zsh-users/zsh-autosuggestions \

# b. Autocomplete
# zinit wait"0b" lucid light-mode for \
zinit lucid light-mode for \
	blockf atpull'zinit creinstall -q .' \
		zsh-users/zsh-completions \
		marlonrichert/zsh-autocomplete # Instant autosuggestions - load instantly

# c. Fast-syntax-highlighting
#zinit wait"0c" lucid light-mode for \
zinit lucid light-mode for \
    atinit"ZINIT[COMPINIT_OPTS]=-C; zpcompinit; zpcdreplay" \
        zdharma/fast-syntax-highlighting

# History substring search
zinit ice wait"1" lucid
zinit light zsh-users/zsh-history-substring-search

# zsh-fnm
zinit ice wait"2" lucid \
    atinit"export ZSH_FNM_NODE_VERSION='16.4.0'"
zinit light "dominik-schwabe/zsh-fnm"

# dotbare dotfiles manager
zinit ice wait"5" lucid
zinit light kazhala/dotbare

# calculator
zinit light arzzen/calc.plugin.zsh
