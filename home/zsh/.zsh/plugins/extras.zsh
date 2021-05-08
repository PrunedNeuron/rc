# Extras - unnecessary but useful plugins

# Aliases for systemd
zinit ice wait"2" lucid
zinit load le0me55i/zsh-systemd

# gitio - git.io url shortener
zinit ice wait"2" lucid
zinit load denysdovhan/gitio-zsh

# jq-zsh-plugin
zinit ice wait"2" lucid
zinit load reegnz/jq-zsh-plugin

# colorize
zinit ice wait"2" lucid
zinit load zpm-zsh/colorize

## LS_COLORS
## Disabled for now
# zinit ice atclone"dircolors -b LS_COLORS > clrs.zsh" \
#     atpull'%atclone' pick"clrs.zsh" nocompile'!' \
#     atload'zstyle ":completion:*" list-colors “${(s.:.)LS_COLORS}”'
# zinit light trapd00r/LS_COLORS

# improved ls
zinit ice wait"2" lucid
zinit load zpm-zsh/ls

zinit ice wait"2" lucid
zinit load zpm-zsh/material-colors

# SSH
zinit ice wait"2" lucid
zinit load zpm-zsh/ssh

# Git shortcut (add + commit + pull + push)
zinit ice wait"2" lucid
zinit load robertzk/send.zsh
