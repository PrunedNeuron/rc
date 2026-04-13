# $ZCONFDIR/widgets/fzf-pacman.zsh
#
# Comprehensive interactive package management hub via fzf.
# Alt+M opens an operation selector; each operation launches a full fzf interface.
#
# Standalone functions (autoloaded from functions.d/):
#   pai   fuzzy install from repos + AUR (multi-select)
#   par   fuzzy remove installed packages (multi-select)
#   pao   fuzzy remove orphaned packages (multi-select)
#   pls   browse/inspect installed packages
#   pup   system upgrade (with confirmation)
#   pfi   find which package owns a given file
#
# Inside every fzf session:
#   Ctrl+Space  mark/unmark item (multi-select)
#   Ctrl+A      toggle-all
#   Tab         accept + apply to all marked
#   Ctrl+/      toggle preview pane
#   Ctrl+Y      copy package name to clipboard
#
# Preview shows:
#   - pacman -Si  (sync DB — official repos)
#   - pacman -Qi  (local DB — installed packages)
#   - pacman -Fl  (file list — installed packages)
#   - yay -Si     (AUR info fallback)

# ── Shared preview expressions ─────────────────────────────────────────────────
# These are used both inside widget functions and exported so autoloaded
# functions can reference them if needed.
typeset -g _PAC_PREVIEW='
  p={1}
  info=$(pacman -Si "$p" 2>/dev/null)
  if [[ -n $info ]]; then
    echo "$info"
    echo
    printf "%-20s%s\n" "──Files(head30)──" ""
    pacman -Fl "$p" 2>/dev/null | awk "{print \$2}" | head -30
  else
    info=$(pacman -Qi "$p" 2>/dev/null)
    if [[ -n $info ]]; then
      echo "$info"
      echo
      pacman -Ql "$p" 2>/dev/null | awk "{print \$2}" | head -30
    else
      command -v yay  &>/dev/null && yay  -Si "$p" 2>/dev/null && return
      command -v paru &>/dev/null && paru -Si "$p" 2>/dev/null && return
      echo "(no package info available for: $p)"
    fi
  fi
'

typeset -g _PAC_INSTALLED_PREVIEW='
  p={1}
  pacman -Qi "$p" 2>/dev/null
  echo
  pacman -Ql "$p" 2>/dev/null | awk "{print \$2}" | head -35
'

# ── Common fzf options for all package operations ─────────────────────────────
typeset -g _PAC_FZF_OPTS=(
  '--multi'
  '--ansi'
  '--scheme=default'
  '--preview-window=right:55%:border-rounded:wrap'
  '--bind=ctrl-space:toggle+down'
  '--bind=ctrl-a:toggle-all'
  '--bind=ctrl-/:toggle-preview'
  '--bind=ctrl-y:execute-silent(echo -n {1} | wl-copy 2>/dev/null || echo -n {1} | xclip -selection clipboard 2>/dev/null)+bell'
)

# ══════════════════════════════════════════════════════════════════════════════
# ZLE widget — package manager hub (Alt+M)
# ══════════════════════════════════════════════════════════════════════════════
_fzf_pkg_hub() {
  local -a ops=(
    'pai     ── fuzzy install from repos + AUR'
    'par     ── fuzzy remove installed packages'
    'pao     ── remove orphaned (unrequired) packages'
    'pls     ── browse & inspect installed packages'
    'pup     ── full system upgrade'
    'pfi     ── find which package owns a file'
    'pcc     ── clean package cache interactively'
  )

  local choice
  choice=$(
    printf '%s\n' "${ops[@]}" \
    | fzf \
        --prompt='pkg ❯ ' \
        --height=45% \
        --min-height=10 \
        --layout=reverse \
        --border=rounded \
        --no-preview \
        --header='Package Manager Hub — pick an operation (Esc to cancel)'
  )
  [[ -z $choice ]] && { zle reset-prompt; return }

  # Extract the function name (first word before spaces/dash)
  local cmd=${choice%%[[:space:]]*}
  BUFFER="$cmd"
  zle accept-line
}
zle -N _fzf_pkg_hub
bindkey -M emacs '^[m' _fzf_pkg_hub
bindkey -M viins '^[m' _fzf_pkg_hub
bindkey -M vicmd '^[m' _fzf_pkg_hub
