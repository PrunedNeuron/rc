# Extras - to make the ZSH experience even better!

# Pacman command finder
# zi ice svn
# zi snippet OMZP::command-not-found

# zoxide
# zi ice wait"2" as"command" from"gh-r" lucid \
#   mv"zoxide*/zoxide -> zoxide" \
#   atclone"./zoxide init --cmd j zsh > init.zsh" \
#   atpull"%atclone" src"init.zsh" nocompile'!'
# zi light ajeetdsouza/zoxide

# Git extras
zi wait"[ -d .git ] || git rev-parse --git-dir > /dev/null 2>&1" lucid light-mode for \
    robertzk/send.zsh

# Utilities
zi wait"2" lucid light-mode for \
    MichaelAquilina/zsh-you-should-use \
    le0me55i/zsh-systemd \
    zpm-zsh/colorize \
    zpm-zsh/undollar \
    zpm-zsh/colors
#    zpm-zsh/ls

# fnm (Fast node manager)
zi ice wait'2' lucid \
  atinit'export ZSH_FNM_NODE_VERSION=$NODEVER'
zi light dominik-schwabe/zsh-fnm
