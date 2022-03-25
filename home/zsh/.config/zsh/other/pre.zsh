# ~/.zsh/pre.zsh
# Runs before compinit

# Install zinit if not installed
if [[ ! -f $HOME/.local/share/zinit/zinit.git/zinit.zsh ]]; then
    print -P "%F{yellow}Installing %F{blue}zinit %F{yellow}(%F{blue}zdharma-continuum/zinit%F{yellow}).%f"
    command mkdir -p "$HOME/.local/share/zinit" && command chmod g-rwX "$HOME/.local/share/zinit"
    command git clone https://github.com/zdharma-continuum/zinit "$HOME/.local/share/zinit/zinit.git" && \
        print -P "%F{34}Installation successful.%f%b" || \
        print -P "%F{160} The clone has failed.%f%b"
fi

ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"
source "${ZINIT_HOME}/zinit.zsh"

# Load zinit module and run compinit
# autoload -Uz _zinit
# (( ${+_comps} )) && _comps[zinit]=_zinit

# Add precmd and chpwd hooks
source $ZCONFDIR/hooks.zsh
