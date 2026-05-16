# zimfw/bootstrap.zsh — Install zimfw on first run; rebuild init.zsh when
# .zimrc is newer than the generated init. No-op on normal startups (~0ms).
#
# ZIM_HOME resolution order:
#   1. $ZDATADIR/zimfw          — preferred: XDG-compliant, already exported
#   2. $XDG_DATA_HOME/zsh/zimfw — explicit XDG fallback if ZDATADIR is unset
#   3. $HOME/.local/share/zsh/zimfw — XDG default path, no env dependency
#
# The old ~/.zim location is intentionally not in the fallback chain.
# If migrating, delete ~/.zim after confirming the new path works.
export ZIM_HOME="${ZDATADIR:-${XDG_DATA_HOME:-$HOME/.local/share}/zsh}/zimfw"

# First-run: download zimfw.zsh if absent.
if [[ ! -e $ZIM_HOME/zimfw.zsh ]]; then
  mkdir -p "$ZIM_HOME"
  curl -fsSL -o "$ZIM_HOME/zimfw.zsh" \
    https://github.com/zimfw/zimfw/releases/latest/download/zimfw.zsh
fi

# Rebuild init.zsh only when .zimrc is newer than the generated init.
if [[ ! $ZIM_HOME/init.zsh -nt ${ZIM_CONFIG_FILE:-$HOME/.zimrc} ]]; then
  source "$ZIM_HOME/zimfw.zsh" init -q
fi
