# Extras - to make the ZSH experience even better!

# Pacman command finder
zinit ice svn
zinit snippet OMZP::command-not-found

# zoxide
zinit ice wait"2" as"command" from"gh-r" lucid \
  mv"zoxide*/zoxide -> zoxide" \
  atclone"./zoxide init zsh > init.zsh" \
  atpull"%atclone" src"init.zsh" nocompile'!'
zinit light ajeetdsouza/zoxide

# Git extras
zinit wait"[ -d .git ] || git rev-parse --git-dir > /dev/null 2>&1" lucid light-mode for \
    robertzk/send.zsh

# Utilities
zinit wait"2" lucid light-mode for \
    MichaelAquilina/zsh-you-should-use \
    le0me55i/zsh-systemd \
    zpm-zsh/colorize \
    zpm-zsh/ls

# fnm (Fast node manager)
zinit ice wait'2' lucid \
  atinit'export ZSH_FNM_NODE_VERSION=$NODEVER'
zinit light dominik-schwabe/zsh-fnm
