# widgets/pacman.zsh — Interactive Arch package management hub. Alt+M.
# Hub → operation picker → full fzf interface for each operation.
#
# These function definitions shadow any same-named autoloaded functions from
# functions.d/ and are the canonical implementations.
#
# Ctrl+Space  mark/unmark    Ctrl+A  toggle-all
# Tab         accept marked  Ctrl+/  toggle preview  Ctrl+Y  copy name

# ── Shared previews ───────────────────────────────────────────────────────────
# typeset -g: these are referenced inside functions at call time (not definition
# time), so they must remain set for the lifetime of the shell session.
typeset -g _PAC_PREVIEW='
  p={1}
  if info=$(pacman -Si "$p" 2>/dev/null); then
    printf "%s\n" "$info"
    printf "\n\033[2m── Files (head 30) ────────────────────────────────\033[0m\n"
    pacman -Fl "$p" 2>/dev/null | awk "{print \$2}" | head -30
  elif info=$(pacman -Qi "$p" 2>/dev/null); then
    printf "%s\n" "$info"
    printf "\n\033[2m── Installed files (head 30) ───────────────────────\033[0m\n"
    pacman -Ql "$p" 2>/dev/null | awk "{print \$2}" | head -30
  else
    command -v yay  &>/dev/null && yay  -Si "$p" 2>/dev/null && return
    command -v paru &>/dev/null && paru -Si "$p" 2>/dev/null && return
    echo "(no package info available for: $p)"
  fi
'

typeset -g _PAC_INSTALLED_PREVIEW='
  p={1}
  pacman -Qi "$p" 2>/dev/null
  printf "\n\033[2m── Installed files (head 35) ───────────────────────\033[0m\n"
  pacman -Ql "$p" 2>/dev/null | awk "{print \$2}" | head -35
'

# Shared fzf flags for all package operations.
# typeset -ga: global array; referenced by name in each function.
typeset -ga _PAC_FZF_OPTS=(
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
  local choice
  choice=$(
    printf '%s\n' \
      'pai  ── fuzzy install from repos + AUR' \
      'par  ── fuzzy remove installed packages' \
      'pao  ── remove orphaned packages' \
      'pls  ── browse & inspect installed packages' \
      'pup  ── full system upgrade' \
      'pfi  ── find which package owns a file' \
      'pcc  ── clean package cache' \
    | fzf \
        --prompt='pkg ❯ ' \
        --height=45% \
        --min-height=10 \
        --layout=reverse \
        --border=rounded \
        --no-preview \
        --header='  Package Hub'
  )
  [[ -z $choice ]] && { zle reset-prompt; return }
  BUFFER="${choice%%[[:space:]]*}"
  zle accept-line
}

zle -N _fzf_pkg_hub
bindkey -M emacs '^[m' _fzf_pkg_hub
bindkey -M viins '^[m' _fzf_pkg_hub
bindkey -M vicmd '^[m' _fzf_pkg_hub

# ── pai — fuzzy install ────────────────────────────────────────────────────────
pai() {
  local aur_helper=pacman
  local _h
  for _h in yay paru pikaur; do
    command -v $_h &>/dev/null && { aur_helper=$_h; break }
  done

  # FIX: use zsh array splitting (f) instead of bare word splitting + xargs.
  local -a pkgs
  pkgs=(${(f)"$(
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
  )"})
  (( ${#pkgs} )) && sudo $aur_helper -S "${pkgs[@]}"
}

# ── par — fuzzy remove ────────────────────────────────────────────────────────
par() {
  local -a pkgs
  pkgs=(${(f)"$(
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
  )"})
  (( ${#pkgs} )) && sudo pacman -Rns "${pkgs[@]}"
}

# ── pao — remove orphans ───────────────────────────────────────────────────────
pao() {
  local orphans
  orphans=$(pacman -Qdtq 2>/dev/null)
  [[ -z $orphans ]] && { echo 'No orphaned packages found.'; return }

  local -a selected
  selected=(${(f)"$(
    echo "$orphans" \
    | fzf \
        "${_PAC_FZF_OPTS[@]}" \
        --prompt='orphan ❯ ' \
        --input-label=' Orphans ' \
        --header='  Mark orphans to remove' \
        --header-border=bottom \
        --preview="$_PAC_INSTALLED_PREVIEW"
  )"})
  (( ${#selected} )) && sudo pacman -Rns "${selected[@]}"
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
  local aur_helper='sudo pacman'
  local _h
  for _h in yay paru pikaur; do
    command -v $_h &>/dev/null && { aur_helper=$_h; break }
  done
  print -P "%F{yellow}Upgrading system with %B${aur_helper}%b…%f"
  $aur_helper -Syu
}

# ── pfi — find file owner ─────────────────────────────────────────────────────
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
      'keep-2       keep 2 versions per package  (paccache -rk2)' \
      'keep-1       keep 1 version per package   (paccache -rk1)' \
      'uninstalled  remove cache for uninstalled (paccache -ruk0)' \
      'all          remove ALL cached packages   (paccache -r)' \
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