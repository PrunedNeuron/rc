# ZSH completions

# bat
# zi ice lucid wait as'completion' blockf has'bat' mv'assets/completions/bat.zsh.in -> _bat'
# zi light sharkdp/bat

# pacman
zi ice lucid wait as'completion' blockf has'pacman' mv'zsh_completion.in -> _pacman'
zi snippet https://gitlab.archlinux.org/pacman/pacman/-/raw/master/scripts/completion/zsh_completion.in

# yay
zi ice lucid wait as'completion' blockf has'yay' mv'zsh -> _yay'
zi snippet https://github.com/Jguer/yay/blob/next/completions/zsh

# youtube-dl
zi ice lucid wait as'completion' blockf has"youtube-dl" mv"youtube-dl.plugin.zsh -> _youtube_dl"
zi snippet https://github.com/ytdl-org/youtube-dl/blob/master/youtube-dl.plugin.zsh

# Docker
zi ice lucid wait as'completion' blockf has"docker"
zi snippet https://github.com/docker/cli/blob/master/contrib/completion/zsh/_docker

# Docker compose
zi ice lucid wait as'completion' blockf has"docker-compose"
zi snippet https://github.com/docker/compose/blob/master/contrib/completion/zsh/_docker-compose

# Keybase
zi ice lucid wait as'completion' blockf has"keybase"
zi snippet https://github.com/rbirnie/oh-my-zsh-keybase/blob/master/keybase/_keybase

# fd
zi ice lucid wait as'completion' blockf has"fd"
zi snippet https://github.com/ohmyzsh/ohmyzsh/blob/master/plugins/fd/_fd

# httpie
zi ice lucid wait as'completion' blockf has"http"
zi snippet https://github.com/ohmyzsh/ohmyzsh/blob/master/plugins/httpie/_httpie

# Yarn
zi ice lucid wait as'completion' blockf has"yarn"
zi snippet https://github.com/ohmyzsh/ohmyzsh/blob/master/plugins/yarn/_yarn

# Pip
zi ice lucid wait as'completion' blockf has'pip'
zi snippet https://github.com/ohmyzsh/ohmyzsh/blob/master/plugins/pip/_pip

# Ripgrep
zi ice lucid wait as'completion' blockf has'rg'
zi snippet https://github.com/BurntSushi/ripgrep/blob/master/complete/_rg

# Windscribe
zi ice lucid wait as'completion' blockf has'windscribe'
zi snippet https://github.com/tjquillan/zsh-windscribe-completions/blob/master/_windscribe

# Git
zi ice lucid wait as'completion' blockf has'git' mv'git-completion.zsh -> _git'
zi snippet https://github.com/git/git/blob/master/contrib/completion/git-completion.zsh

# ipfs
zi ice lucid wait as'completion' blockf has'ipfs' mv'_zsh-ipfs -> _ipfs'
zi snippet https://github.com/hellounicorn/zsh-ipfs/blob/master/_zsh-ipfs

# fzf
zi ice lucid wait as'completion' blockf has'fzf' mv'completion.zsh -> _fzf'
zi snippet https://github.com/junegunn/fzf/blob/master/shell/completion.zsh

# paru
zi ice lucid wait as'completion' blockf has'cargo' mv'zsh -> _paru'
zi snippet https://github.com/Morganamilo/paru/blob/master/completions/zsh

# More completions
zi ice lucid wait as'completion' blockf has'go'
zi light zchee/zsh-completions

zi ice lucid wait as'completion' blockf has'pacman'
zi light clarketm/zsh-completions

zi ice lucid wait as'completion' blockf has'conda'
zi light conda-incubator/conda-zsh-completion

