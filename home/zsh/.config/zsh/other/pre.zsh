# $ZCONFDIR/other/pre.zsh
# Bootstraps zimfw. ZIM_HOME must be set first — all subsequent lines reference it.

ZIM_HOME=${ZDOTDIR:-$HOME}/.zim

# Download zimfw script if missing (first install only)
if [[ ! -e $ZIM_HOME/zimfw.zsh ]]; then
  curl -fsSL --create-dirs -o $ZIM_HOME/zimfw.zsh \
    https://github.com/zimfw/zimfw/releases/latest/download/zimfw.zsh
fi

# Rebuild init.zsh only when .zimrc is newer — a no-op on normal startups
if [[ ! $ZIM_HOME/init.zsh -nt ${ZIM_CONFIG_FILE:-${ZDOTDIR:-$HOME}/.zimrc} ]]; then
  source $ZIM_HOME/zimfw.zsh init -q
fi

# zsh-defer is loaded by init.zsh (post.zsh). No pre-bootstrap needed here.
