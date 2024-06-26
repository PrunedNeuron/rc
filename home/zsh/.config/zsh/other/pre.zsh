# ~/.config/zsh/other/pre.zsh
# Runs before compinit

ZINIT_HOME="$ZDATADIR/zinit"

# Install zinit if not installed
if [[ ! -f "$ZINIT_HOME/zinit.zsh" ]]; then
    print -P "%F{yellow}Installing %F{blue}zinit %F{yellow}(%F{blue}zdharma-continuum/zinit%F{yellow}).%f"
    command mkdir -p "$ZINIT_HOME" && command chmod g-rwX "$ZINIT_HOME"
    command git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME" && \
        print -P "%F{34}Installation successful.%f%b" || \
        print -P "%F{160} The clone has failed.%f%b"
fi

source "${ZINIT_HOME}/zinit.zsh"

# Load zinit module and run compinit
# autoload -Uz _zinit
# (( ${+_comps} )) && _comps[zinit]=_zinit

# Fig pre block. Keep at the top of this file.
# [[ -f "$HOME/.fig/shell/zshrc.pre.zsh" ]] && . "$HOME/.fig/shell/zshrc.pre.zsh"

# Add precmd and chpwd hooks
source $ZCONFDIR/hooks.zsh

# Add zsh mods
source $ZCONFDIR/zmods.zsh
