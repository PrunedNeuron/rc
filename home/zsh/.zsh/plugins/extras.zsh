# Extras - to make the ZSH experience even better!

# zsh-you-should-use (Recommends aliases that you could have used)
zinit ice wait"2" lucid
zinit light MichaelAquilina/zsh-you-should-use

# ls -> exa aliases, colorization for several commands
zinit wait"2" lucid light-mode for \
    zpm-zsh/ls \
    zpm-zsh/material-colors \
    zpm-zsh/colorize \
    ael-code/zsh-colored-man-pages

# Git extras
zinit wait"[ -d .git ] || git rev-parse --git-dir > /dev/null 2>&1" lucid light-mode for \
    mdumitru/git-aliases \
    ltj/gitgo \
    robertzk/send.zsh \
    voronkovich/gitignore.plugin.zsh

# Utilities
zinit wait"2" lucid light-mode for \
    le0me55i/zsh-systemd \
    reegnz/jq-zsh-plugin \
    zpm-zsh/ssh \
    denysdovhan/gitio-zsh \
    agkozak/zhooks
