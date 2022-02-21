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

# Git extras
# zinit lucid wait"5" for \
#     as"program" pick"$ZPFX/bin/git-*" src"etc/git-extras-completion.zsh" make"PREFIX=$ZPFX" \
#         tj/git-extras

# zsh-fnm
# zinit ice wait"5" lucid \
#     atinit"export ZSH_FNM_NODE_VERSION='17.2.0'"
# zinit light "dominik-schwabe/zsh-fnm"

# Utilities
zinit wait"2" lucid light-mode for \
    le0me55i/zsh-systemd \
    marzocchi/zsh-notify \
    zpm-zsh/colorize \
    zpm-zsh/ls

zinit wait"5" lucid light-mode for \
    MichaelAquilina/zsh-you-should-use \
    le0me55i/zsh-extract \
    supercrabtree/k
