# $ZCONFDIR/widgets/fzf-pacman.zsh — interactive Arch package management hub.
# Alt+M → operation selector → full fzf interface for each operation.
#
# Standalone autoloaded functions (put these in $ZCONFDIR/functions.d/):
#   pai   fuzzy install from repos + AUR
#   par   fuzzy remove installed packages
#   pao   fuzzy remove orphaned packages
#   pls   browse/inspect installed packages
#   pup   system upgrade
#   pfi   find which package owns a file
#   pcc   clean package cache interactively
#
# Common fzf bindings (all pkg sessions):
#   Ctrl+Space  mark/unmark     Ctrl+A  toggle-all
#   Tab         accept marked   Ctrl+/  toggle preview
#   Ctrl+Y      copy name to clipboard

# ── Shared preview fragments ───────────────────────────────────────────────────
typeset -g _PAC_PREVIEW='
  p={1}
  info=$(pacman -Si "$p" 2>/dev/null)
  if [[ -n $info ]]; then
    echo "$info"
    echo
    printf "── Files (head 30) ────────────────────────────────\n"
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

# ── Package hub ZLE widget (Alt+M) ───────────────────────────────────────────
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
        --header='  Package Hub — pick an operation'
  )
  [[ -z $choice ]] && { zle reset-prompt; return }

  local cmd=${choice%%[[:space:]]*}
  BUFFER="$cmd"
  zle accept-line
}

zle -N _fzf_pkg_hub
bindkey -M emacs '^[m' _fzf_pkg_hub
bindkey -M viins '^[m' _fzf_pkg_hub
bindkey -M vicmd '^[m' _fzf_pkg_hub

# ── pai — fuzzy install ────────────────────────────────────────────────────────
pai() {
  local aur_helper
  for aur_helper in yay paru pikaur; do
    command -v $aur_helper &>/dev/null && break
    aur_helper=pacman
  done

  local pkgs
  pkgs=$(
    $aur_helper -Slq 2>/dev/null \
    | fzf \
        "${_PAC_FZF_OPTS[@]}" \
        --prompt='install ❯ ' \
        --input-label=' Install ' \
        --header='  Mark with Ctrl+Space, accept with Tab' \
        --header-border=bottom \
        --bind="load:transform-footer:echo ' \$FZF_TOTAL_COUNT packages'" \
        --footer-border=top \
        --preview="$_PAC_PREVIEW"
  )
  [[ -z $pkgs ]] && return
  sudo $aur_helper -S ${(f)pkgs}
}

# ── par — fuzzy remove ────────────────────────────────────────────────────────
par() {
  local pkgs
  pkgs=$(
    pacman -Qeq 2>/dev/null \
    | fzf \
        "${_PAC_FZF_OPTS[@]}" \
        --prompt='remove ❯ ' \
        --input-label=' Remove ' \
        --header='  Mark packages to remove' \
        --header-border=bottom \
        --bind="load:transform-footer:echo ' \$FZF_TOTAL_COUNT installed'" \
        --footer-border=top \
        --preview="$_PAC_INSTALLED_PREVIEW"
  )
  [[ -z $pkgs ]] && return
  sudo pacman -Rns ${(f)pkgs}
}

# ── pao — remove orphans ───────────────────────────────────────────────────────
pao() {
  local pkgs
  pkgs=$(pacman -Qdtq 2>/dev/null)
  [[ -z $pkgs ]] && { echo 'No orphaned packages found.'; return }
  echo "$pkgs" \
  | fzf \
      "${_PAC_FZF_OPTS[@]}" \
      --prompt='orphan ❯ ' \
      --input-label=' Orphans ' \
      --header='  Mark orphans to remove (Tab to confirm)' \
      --header-border=bottom \
      --preview="$_PAC_INSTALLED_PREVIEW" \
  | xargs -r sudo pacman -Rns
}

# ── pls — browse installed ────────────────────────────────────────────────────
pls() {
  pacman -Qeq 2>/dev/null \
  | fzf \
      "${_PAC_FZF_OPTS[@]}" \
      --prompt='packages ❯ ' \
      --input-label=' Installed ' \
      --header='  Browse installed packages' \
      --header-border=bottom \
      --bind="load:transform-footer:echo ' \$FZF_TOTAL_COUNT packages'" \
      --footer-border=top \
      --preview="$_PAC_INSTALLED_PREVIEW"
}

# ── pup — upgrade ─────────────────────────────────────────────────────────────
pup() {
  local aur_helper
  for aur_helper in yay paru pikaur; do
    command -v $aur_helper &>/dev/null && break
    aur_helper='sudo pacman'
  done
  print -P '%F{yellow}Upgrading system with %B'"$aur_helper"'%b …%f'
  $aur_helper -Syu
}

# ── pfi — file owner ──────────────────────────────────────────────────────────
pfi() {
  local f="${1:-}"
  if [[ -z $f ]]; then
    f=$(
      fzf --scheme=path \
          --prompt='file ❯ ' \
          --preview='bat --style=plain --color=always {} 2>/dev/null || ls -la {}'
    )
  fi
  [[ -z $f ]] && return
  pacman -Qo "$f"
}

# ── pcc — cache clean ─────────────────────────────────────────────────────────
pcc() {
  local choice
  choice=$(
    printf '%s\n' \
      'keep-2   keep 2 versions of each package (paccache -rk2)' \
      'keep-1   keep 1 version of each package  (paccache -rk1)' \
      'uninstalled remove cache for uninstalled  (paccache -ruk0)' \
      'all      remove ALL cached packages       (paccache -r)' \
    | fzf \
        --prompt='cache ❯ ' \
        --height=30% \
        --layout=reverse \
        --border=rounded \
        --no-preview \
        --header='  Choose cache clean strategy'
  )
  [[ -z $choice ]] && return
  case ${choice%% *} in
    keep-2)      sudo paccache -rk2   ;;
    keep-1)      sudo paccache -rk1   ;;
    uninstalled) sudo paccache -ruk0  ;;
    all)         sudo paccache -r     ;;
  esac
}
