# Extras - to make the ZSH experience even better!

# zoxide
zinit ice wait"2" as"command" from"gh-r" lucid \
  mv"zoxide*/zoxide -> zoxide" \
  atclone"./zoxide init zsh > init.zsh" \
  atpull"%atclone" src"init.zsh" nocompile'!'
zinit light ajeetdsouza/zoxide

# ls -> exa aliases, colorization for several commands
zinit wait"2" lucid light-mode for \
    zpm-zsh/colorize
    # zpm-zsh/ls

# enhancd -> next gen `cd` command with an interactive filter
zinit ice wait lucid
zinit light b4b4r07/enhancd

# Git extras
zinit wait"[ -d .git ] || git rev-parse --git-dir > /dev/null 2>&1" lucid light-mode for \
    ltj/gitgo \
    wfxr/forgit \
    robertzk/send.zsh \
    mdumitru/git-aliases \
    voronkovich/gitignore.plugin.zsh

# Git extras
zinit lucid wait'0a' for \
    as"program" pick"$ZPFX/bin/git-*" src"etc/git-extras-completion.zsh" make"PREFIX=$ZPFX" \
        tj/git-extras

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

# zsh-fnm
zinit ice wait"2" lucid \
    atinit"export ZSH_FNM_NODE_VERSION='16.4.0'"
zinit light "dominik-schwabe/zsh-fnm"

# Utilities
zinit wait"2" lucid light-mode for \
    agkozak/zhooks \
    le0me55i/zsh-extract \
    le0me55i/zsh-systemd \
    reegnz/jq-zsh-plugin \
    hlissner/zsh-autopair \
    denysdovhan/gitio-zsh \
    MichaelAquilina/zsh-you-should-use \
    arzzen/calc.plugin.zsh \
    supercrabtree/k

