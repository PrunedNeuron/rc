# Extras - to make the ZSH experience even better!

# zoxide
zinit ice wait"2" as"command" from"gh-r" lucid \
  mv"zoxide*/zoxide -> zoxide" \
  atclone"./zoxide init zsh > init.zsh" \
  atpull"%atclone" src"init.zsh" nocompile'!'
zinit light ajeetdsouza/zoxide

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

# fzf extras
# fuzzy-sys (fuzzy systemctl)
zinit ice wait"2" lucid \
    atload"alias fzsys='fuzzy-sys'"
zinit light NullSense/fuzzy-sys

# Fuzzy finder
zinit has'fzf' lucid light-mode for \
    atload'source "$HOME/.config/fzf/config"' \
        changyuheng/zsh-interactive-cd \
        leophys/zsh-plugin-fzf-finder \
        chitoku-k/fzf-zsh-completions \
        atweiden/fzf-extras

# zsh-fnm
zinit ice wait"2" lucid \
    atinit"export ZSH_FNM_NODE_VERSION='17.2.0'"
zinit light "dominik-schwabe/zsh-fnm"

# Utilities
zinit wait"2" lucid light-mode for \
    MichaelAquilina/zsh-you-should-use \
    arzzen/calc.plugin.zsh \
    le0me55i/zsh-extract \
    le0me55i/zsh-systemd \
    hlissner/zsh-autopair \
    marzocchi/zsh-notify \
    supercrabtree/k \
    gko/ssh-connect \
    agkozak/zhooks \
    zpm-zsh/colorize \
    zpm-zsh/ls
