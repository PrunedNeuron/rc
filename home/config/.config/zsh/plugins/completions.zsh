# ZSH completions

# Docker
zinit ice as"completion"
zinit snippet https://github.com/docker/cli/blob/master/contrib/completion/zsh/_docker

# Docker compose
zinit ice as"completion" has"docker-compose"
zinit snippet https://github.com/docker/compose/blob/master/contrib/completion/zsh/_docker-compose

# Keybase
zinit ice as"completion" has"keybase"
zinit snippet https://github.com/rbirnie/oh-my-zsh-keybase/blob/master/keybase/_keybase

# fd
zinit ice as"completion" has"fd"
zinit snippet https://github.com/ohmyzsh/ohmyzsh/blob/master/plugins/fd/_fd

# httpie
zinit ice as"completion" has"http"
zinit snippet https://github.com/ohmyzsh/ohmyzsh/blob/master/plugins/httpie/_httpie

# Yarn
zinit ice as"completion" has"yarn"
zinit snippet https://github.com/ohmyzsh/ohmyzsh/blob/master/plugins/yarn/_yarn

# Pip
zinit ice as"completion" has"pip"
zinit snippet https://github.com/ohmyzsh/ohmyzsh/blob/master/plugins/pip/_pip

# Ripgrep
zinit ice as"completion" has"rg"
zinit snippet https://github.com/BurntSushi/ripgrep/blob/master/complete/_rg

# Windscribe
zinit ice as"completion" has"windscribe"
zinit snippet https://github.com/tjquillan/zsh-windscribe-completions/blob/master/_windscribe

# Git
zinit ice as"completion" has"git"
zinit snippet https://github.com/git/git/blob/master/contrib/completion/git-completion.zsh

# More yarn
zinit ice atload"zpcdreplay" atclone'./zplug.zsh'
zinit light g-plane/zsh-yarn-autocompletions

# More completions
zinit ice wait"5" lucid
zinit light zchee/zsh-completions
