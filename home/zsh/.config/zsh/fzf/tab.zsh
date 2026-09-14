# fzf/tab.zsh — fzf-tab configuration.
#
# This file may be sourced before compinit because it only installs zstyles.
# The fzf-tab PLUGIN itself, however, MUST load after Zim's completion module
# (compinit) and before plugins that wrap ZLE widgets. .zimrc enforces that.

# Do not inherit FZF_DEFAULT_OPTS wholesale. fzf-tab explicitly warns that some
# global fzf options can break its protocol; mirror the desired UI here instead.
zstyle ':fzf-tab:*' use-fzf-default-opts no

# ══════════════════════════════════════════════════════════════════════════════
# Base fzf-tab flags
# ══════════════════════════════════════════════════════════════════════════════
_fzf_tab_flags=(
  '--height=70%'
  '--min-height=16+'
  '--layout=reverse'
  '--style=default'
  '--border=rounded'
  '--padding=0,1'
  '--info=inline-right'
  '--prompt=❯ '
  '--pointer=▶'
  '--marker=✓'
  '--separator=─'
  '--scrollbar=│'
  '--cycle'
  '--scroll-off=5'
  '--highlight-line'
  '--multi'
  '--exit-0'
  '--preview-window=right:55%:border-rounded:wrap'
  '--color=bg+:#313244,bg:#1e1e2e,spinner:#f5e0dc,hl:#f38ba8'
  '--color=fg:#cdd6f4,header:#f38ba8,info:#cba6f7,pointer:#f5e0dc'
  '--color=marker:#b4befe,fg+:#cdd6f4,prompt:#cba6f7,hl+:#f38ba8'
  '--color=selected-bg:#45475a,border:#585b70,label:#cdd6f4'
  '--color=preview-bg:#1e1e2e,preview-border:#585b70,preview-label:#cdd6f4'
  '--color=gutter:#1e1e2e,query:#cdd6f4,disabled:#6c7086'
  '--color=input-border:#585b70,input-label:#cba6f7'
  '--color=list-border:#45475a,header-border:#585b70'
  '--bind=tab:accept'
  '--bind=btab:up'
  '--bind=ctrl-space:toggle+down'
  '--bind=ctrl-a:toggle-all'
  '--bind=ctrl-/:toggle-preview'
  '--bind=alt-up:preview-up'
  '--bind=alt-down:preview-down'
  '--bind=alt-f:preview-page-down'
  '--bind=alt-b:preview-page-up'
  '--bind=alt-e:preview-top'
  '--bind=alt-E:preview-bottom'
  '--bind=ctrl-s:toggle-sort'
)

# Preserve your tmux popup UX without leaking a global --tmux flag into fzf-tab.
[[ -n ${TMUX-} ]] && _fzf_tab_flags+=( '--tmux=center,85%' )

zstyle ':fzf-tab:*' fzf-flags "${_fzf_tab_flags[@]}"

# ══════════════════════════════════════════════════════════════════════════════
# Global actions / navigation
# ══════════════════════════════════════════════════════════════════════════════
zstyle ':fzf-tab:*' fzf-bindings \
  'ctrl-e:execute-silent({_FTB_INIT_}[[ -e "$realpath" ]] && ${EDITOR:-nvim} "$realpath" </dev/tty >/dev/tty)' \
  'ctrl-y:execute-silent({_FTB_INIT_}printf %s "${realpath:-$word}" | (wl-copy 2>/dev/null || xclip -selection clipboard 2>/dev/null))' \
  'ctrl-o:execute-silent({_FTB_INIT_}[[ -e "$realpath" ]] && xdg-open "$realpath" >/dev/null 2>&1)'

zstyle ':fzf-tab:*' switch-group '<' '>'
zstyle ':fzf-tab:*' continuous-trigger '/'
zstyle ':fzf-tab:*' show-group full
zstyle ':fzf-tab:*' popup-min-size 80 16

# ══════════════════════════════════════════════════════════════════════════════
# Shared file/directory preview
# ══════════════════════════════════════════════════════════════════════════════
_fzf_tab_file_preview='
  if [[ -d "$realpath" ]]; then
    eza --tree --level=2 --color=always --icons=auto "$realpath" 2>/dev/null \
      || ls -la -- "$realpath"
  elif [[ -f "$realpath" ]]; then
    bat --style=numbers,changes --color=always --line-range=:240 -- "$realpath" 2>/dev/null \
      || file --brief -- "$realpath"
  else
    printf "%s\\n" "$word"
  fi
'

# Catch-all first; more-specific contexts win automatically via zstyle lookup.
zstyle ':fzf-tab:complete:*:*' fzf-preview "$_fzf_tab_file_preview"

# ── Directories ───────────────────────────────────────────────────────────────
zstyle ':fzf-tab:complete:(cd|pushd|rmdir):*' fzf-preview \
  'eza --tree --level=3 --color=always --icons=auto "$realpath" 2>/dev/null || ls -la -- "$realpath"'
zstyle ':fzf-tab:complete:cd:*' popup-min-size 60 16

# ── File-manipulating commands ────────────────────────────────────────────────
zstyle ':fzf-tab:complete:(ls|eza|exa|lsd|stat|file|wc|head|tail|diff|patch|cp|mv|rm|ln|chmod|chown):*' \
  fzf-preview "$_fzf_tab_file_preview"

# ── Editors ───────────────────────────────────────────────────────────────────
zstyle ':fzf-tab:complete:(nvim|vim|vi|nano|hx|code|emacs):*' fzf-preview \
  'bat --style=numbers,changes --color=always --line-range=:320 -- "$realpath" 2>/dev/null || file --brief -- "$realpath"'

# ── Git ───────────────────────────────────────────────────────────────────────
zstyle ':fzf-tab:complete:git-(add|diff|restore|reset|rm):*' fzf-preview \
  'git diff --color=always -- "$word" 2>/dev/null | delta 2>/dev/null \
   || git diff --color=always -- "$word" 2>/dev/null \
   || bat --style=numbers,changes --color=always -- "$realpath" 2>/dev/null'

zstyle ':fzf-tab:complete:git-log:*' fzf-preview \
  'git log --color=always --oneline --graph --decorate "$word" 2>/dev/null'

zstyle ':fzf-tab:complete:git-show:*' fzf-preview \
  'git show --color=always "$word" 2>/dev/null | delta 2>/dev/null \
   || git show --color=always "$word" 2>/dev/null'

zstyle ':fzf-tab:complete:git-checkout:*' fzf-preview \
  'case "$group" in
     "modified file")
       git diff --color=always -- "$word" 2>/dev/null | delta 2>/dev/null \
         || git diff --color=always -- "$word" 2>/dev/null ;;
     "recent commit object name")
       git show --color=always "$word" 2>/dev/null | delta 2>/dev/null \
         || git show --color=always "$word" 2>/dev/null ;;
     *)
       git log --color=always --oneline --graph --decorate "$word" 2>/dev/null ;;
   esac'

zstyle ':fzf-tab:complete:git-help:*' fzf-preview \
  'MANPAGER=cat git help "$word" 2>/dev/null | col -bx 2>/dev/null | head -100 | bat --language=man --style=plain --color=always 2>/dev/null'

# ── Systemd ───────────────────────────────────────────────────────────────────
zstyle ':fzf-tab:complete:systemctl:*' fzf-preview \
  'SYSTEMD_COLORS=1 systemctl status --no-pager -- "$word" 2>/dev/null'
zstyle ':fzf-tab:complete:journalctl:*' fzf-preview \
  'SYSTEMD_COLORS=1 journalctl --no-pager -n 80 -u "$word" 2>/dev/null'

# ── Processes ─────────────────────────────────────────────────────────────────
zstyle ':fzf-tab:complete:kill:argument-rest' fzf-preview \
  'ps --pid="$word" -o pid,user,pcpu,pmem,etime,comm,args --no-headers -w -w 2>/dev/null'
# A more-specific fzf-flags style replaces, rather than merges with, the global
# one, so explicitly carry the entire base array forward before overriding only
# preview geometry.
zstyle ':fzf-tab:complete:kill:argument-rest' fzf-flags \
  "${_fzf_tab_flags[@]}" '--preview-window=down:7:wrap'

# ── Man pages ─────────────────────────────────────────────────────────────────
zstyle ':fzf-tab:complete:(\\|*/|)man:*' fzf-preview \
  'MANPAGER=cat man "$word" 2>/dev/null | col -bx 2>/dev/null | head -100 | bat --language=man --style=plain --color=always 2>/dev/null'

# ── Environment variables ─────────────────────────────────────────────────────
zstyle ':fzf-tab:complete:(-command-|-parameter-|-brace-parameter-|export|unset|expand):*' \
  fzf-preview 'typeset -p "$word" 2>/dev/null || print -r -- "${(P)word}" 2>/dev/null'

# ── Docker ────────────────────────────────────────────────────────────────────
zstyle ':fzf-tab:complete:docker-(run|pull|push|tag|rmi|inspect):*' fzf-preview \
  'docker inspect "$word" 2>/dev/null | head -120 | bat --language=json --style=plain --color=always 2>/dev/null'

# ── Pacman / AUR helpers ──────────────────────────────────────────────────────
# Keep previews local-only: no AUR request on every cursor movement.
_pac_preview='
  p="${word%%[[:space:]]*}"
  p="${p%%[[:space:]]──*}"
  if info=$(pacman -Si "$p" 2>/dev/null); then
    printf "%s\\n" "$info"
    printf "\\n\\033[2m── Files (head 20) ──────────────────────────────────\\033[0m\\n"
    pacman -Fl "$p" 2>/dev/null | awk "{print \\$2}" | head -20
  elif info=$(pacman -Qi "$p" 2>/dev/null); then
    printf "%s\\n" "$info"
    printf "\\n\\033[2m── Installed files (head 20) ────────────────────────\\033[0m\\n"
    pacman -Ql "$p" 2>/dev/null | awk "{print \\$2}" | head -20
  else
    printf "\\033[2m(AUR-only — not in sync/local DB)\\033[0m\\n"
    printf "Run: yay -Si %s\\n" "$p"
  fi
'
for _pm in pacman yay paru pikaur trizen; do
  zstyle ":fzf-tab:complete:${_pm}:*" fzf-preview "$_pac_preview"
done
unset _pm _pac_preview

# ── Python / Cargo / Flatpak ──────────────────────────────────────────────────
zstyle ':fzf-tab:complete:pip(|3):*' fzf-preview \
  'pip show "$word" 2>/dev/null | bat --language=yaml --style=plain --color=always 2>/dev/null'

zstyle ':fzf-tab:complete:cargo:*' fzf-preview \
  'timeout 2s cargo info "$word" 2>/dev/null | head -40'

zstyle ':fzf-tab:complete:flatpak:*' fzf-preview \
  'flatpak info "$word" 2>/dev/null | head -60'

# ── SSH / network ─────────────────────────────────────────────────────────────
zstyle ':fzf-tab:complete:(ssh|scp|sftp):*' fzf-preview \
  'grep -A8 "^[[:space:]]*Host[[:space:]].*${word}" ~/.ssh/config 2>/dev/null | head -16'

zstyle ':fzf-tab:complete:ip:*' fzf-preview \
  'ip addr show "$word" 2>/dev/null || ip link show "$word" 2>/dev/null'

# ── mise ──────────────────────────────────────────────────────────────────────
zstyle ':fzf-tab:complete:mise:*' fzf-preview \
  'mise info "$word" 2>/dev/null | head -40'

unset _fzf_tab_file_preview _fzf_tab_flags
