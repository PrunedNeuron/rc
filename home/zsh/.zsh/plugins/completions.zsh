# ZSH completions

# Docker
zinit ice as"completion"
zinit snippet https://github.com/docker/cli/blob/master/contrib/completion/zsh/_docker

# Keybase
zinit ice as"completion"
zinit snippet https://github.com/rbirnie/oh-my-zsh-keybase/blob/master/keybase/_keybase

## Yarn
## Disabled atm
# zinit ice as"completion" \
#    atload"zpcdreplay" \
#    atclone'./zplug.zsh'
# zinit light g-plane/zsh-yarn-autocompletions
