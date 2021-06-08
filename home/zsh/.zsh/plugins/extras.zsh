# Extras - to make the ZSH experience even better!

# ls -> exa aliases, colorization for several commands
zinit wait"2" lucid light-mode for \
    zpm-zsh/colorize \
 	zpm-zsh/ls

# Git extras
zinit wait"[ -d .git ] || git rev-parse --git-dir > /dev/null 2>&1" lucid light-mode for \
    ltj/gitgo \
    wfxr/forgit \
    robertzk/send.zsh \
    mdumitru/git-aliases \
    voronkovich/gitignore.plugin.zsh

# SSH extras
zinit ice wait"2" lucid
zinit light gko/ssh-connect

# fzf extras
# fuzzy-sys (fuzzy systemctl)
zinit ice wait"2" lucid \
    atload"alias fzsys='fuzzy-sys'"
zinit light NullSense/fuzzy-sys

# Fuzzy finder
zinit has'fzf' lucid light-mode for \
    atload'source "$HOME/.config/fzf/config"' \
        atweiden/fzf-extras \
        leophys/zsh-plugin-fzf-finder \
        changyuheng/zsh-interactive-cd \
        chitoku-k/fzf-zsh-completions

# Utilities
zinit wait"2" lucid light-mode for \
    agkozak/zhooks \
    le0me55i/zsh-extract \
    le0me55i/zsh-systemd \
    reegnz/jq-zsh-plugin \
    hlissner/zsh-autopair \
    denysdovhan/gitio-zsh \
    MichaelAquilina/zsh-you-should-use
