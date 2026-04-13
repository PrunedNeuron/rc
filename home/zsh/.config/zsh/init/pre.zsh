# $ZCONFDIR/init/pre.zsh
# zimfw bootstrap (renamed from other/)

ZIM_HOME="${ZDOTDIR:-$HOME}/.zim"

# First-run: download zimfw if absent
if [[ ! -e $ZIM_HOME/zimfw.zsh ]]; then
  curl -fsSL --create-dirs -o "$ZIM_HOME/zimfw.zsh" \
    https://github.com/zimfw/zimfw/releases/latest/download/zimfw.zsh
fi

# Rebuild init.zsh only when .zimrc is newer — no-op on normal startups
if [[ ! $ZIM_HOME/init.zsh -nt ${ZIM_CONFIG_FILE:-${ZDOTDIR:-$HOME}/.zimrc} ]]; then
  source "$ZIM_HOME/zimfw.zsh" init -q
fi
