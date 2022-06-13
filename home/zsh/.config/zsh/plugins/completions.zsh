# ZSH completions

# tmux panes
zinit ice lucid wait as'completion' blockf has'tmux' pick'completion/zsh'
zinit light greymd/tmux-xpanes

# pandoc
zinit ice lucid wait as'completion' blockf has"pandoc"
zinit light srijanshetty/zsh-pandoc-completion

# youtube-dl
zinit ice lucid wait as'completion' blockf has"youtube-dl" mv"youtube-dl.plugin.zsh -> _youtube_dl"
zinit snippet https://github.com/ytdl-org/youtube-dl/blob/master/youtube-dl.plugin.zsh

# Docker
zinit ice lucid wait as'completion' blockf has"docker"
zinit snippet https://github.com/docker/cli/blob/master/contrib/completion/zsh/_docker

# Docker compose
zinit ice lucid wait as'completion' blockf has"docker-compose"
zinit snippet https://github.com/docker/compose/blob/master/contrib/completion/zsh/_docker-compose

# Keybase
zinit ice lucid wait as'completion' blockf has"keybase"
zinit snippet https://github.com/rbirnie/oh-my-zsh-keybase/blob/master/keybase/_keybase

# fd
zinit ice lucid wait as'completion' blockf has"fd"
zinit snippet https://github.com/ohmyzsh/ohmyzsh/blob/master/plugins/fd/_fd

# httpie
zinit ice lucid wait as'completion' blockf has"http"
zinit snippet https://github.com/ohmyzsh/ohmyzsh/blob/master/plugins/httpie/_httpie

# Yarn
zinit ice lucid wait as'completion' blockf has"yarn"
zinit snippet https://github.com/ohmyzsh/ohmyzsh/blob/master/plugins/yarn/_yarn

# Pip
zinit ice lucid wait as'completion' blockf has"pip"
zinit snippet https://github.com/ohmyzsh/ohmyzsh/blob/master/plugins/pip/_pip

# Ripgrep
zinit ice lucid wait as'completion' blockf has"rg"
zinit snippet https://github.com/BurntSushi/ripgrep/blob/master/complete/_rg

# Windscribe
zinit ice lucid wait as'completion' blockf has"windscribe"
zinit snippet https://github.com/tjquillan/zsh-windscribe-completions/blob/master/_windscribe

# Git
zinit ice lucid wait as'completion' blockf has"git" mv"git-completion.zsh -> _git"
zinit snippet https://github.com/git/git/blob/master/contrib/completion/git-completion.zsh

# ipfs
zinit ice lucid wait as'completion' blockf has"ipfs" mv"_zsh-ipfs -> _ipfs"
zinit snippet https://github.com/hellounicorn/zsh-ipfs/blob/master/_zsh-ipfs

# More completions
# zinit ice lucid wait as'completion' blockf pick"src/go" "src/zsh"
# zinit light zchee/zsh-completions

## Completion plugins
zinit light clarketm/zsh-completions

# fzf
zinit ice lucid wait as'completion' blockf has'fzf' mv'completion.zsh -> _fzf'
zinit snippet https://github.com/junegunn/fzf/blob/master/shell/completion.zsh

# paru
zinit ice lucid wait as'completion' blockf has'cargo' mv'zsh -> _paru'
zinit snippet https://github.com/Morganamilo/paru/blob/master/completions/zsh
