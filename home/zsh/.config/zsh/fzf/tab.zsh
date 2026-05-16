# fzf/tab.zsh — fzf-tab zstyle configuration.
# MUST be sourced before compinit (which fires inside ZIM_HOME/init.zsh).
#
# Multiselect in all fzf-tab popups:
#   Ctrl+Space  toggle + down   (inherited from FZF_DEFAULT_OPTS)
#   Ctrl+A      toggle all      (inherited from FZF_DEFAULT_OPTS)
#   Tab         accept + insert all marked
#   Shift+Tab   navigate up

zstyle ':fzf-tab:*' use-fzf-default-opts yes

# ── Core flags ────────────────────────────────────────────────────────────────
# --style=default: overrides global --style=full. Three extra inner borders
#   in a 70% popup shrink the item list; the outer --border=rounded is kept.
# --exit-0: exit immediately (code 1, no popup) when stdin is empty. fzf-tab
#   treats non-zero exit as "fall back to standard zsh completion", which fixes
#   blank-popup symptoms when completion returns 0 candidates.
# --select-1 is ABSENT: single-match auto-accept hides the preview pane, which
#   is valuable for package inspection.
zstyle ':fzf-tab:*' fzf-flags \
  '--height=70%'      \
  '--min-height=16'   \
  '--multi'           \
  '--style=default'   \
  '--exit-0'          \
  '--bind=tab:accept' \
  '--bind=btab:up'

# ── Global action bindings ────────────────────────────────────────────────────
zstyle ':fzf-tab:*' fzf-bindings \
  'ctrl-e:execute-silent({_FTB_INIT_}${EDITOR:-nvim} "$realpath" </dev/tty >/dev/tty)' \
  'ctrl-y:execute-silent({_FTB_INIT_}wl-copy -- "$realpath" 2>/dev/null || xclip -selection clipboard -- "$realpath" 2>/dev/null)'

zstyle ':fzf-tab:*' switch-group       '<' '>'
zstyle ':fzf-tab:*' continuous-trigger '/'
zstyle ':fzf-tab:*' show-group         full
zstyle ':fzf-tab:*' popup-min-size     80 16

# ── Shared file/directory preview ─────────────────────────────────────────────
# $realpath is the full path of the completion candidate, set by fzf-tab.
# This variable is interpolated into zstyle at source time, so unset is safe.
_ftp='
  if [[ -d $realpath ]]; then
    eza --tree --level=2 --color=always --icons=auto "$realpath" 2>/dev/null \
      || ls -la "$realpath"
  else
    bat --style=numbers,changes --color=always --line-range=:200 "$realpath" 2>/dev/null \
      || cat "$realpath"
  fi
'

# ── Directories ───────────────────────────────────────────────────────────────
zstyle ':fzf-tab:complete:cd:*' fzf-preview \
  'eza --tree --level=2 --color=always --icons=auto $realpath 2>/dev/null || ls -la $realpath'
zstyle ':fzf-tab:complete:cd:*' popup-min-size 60 16

# ── File-manipulating commands ────────────────────────────────────────────────
zstyle ':fzf-tab:complete:(ls|eza|exa|lsd|stat|file|wc|head|tail|diff|patch|cp|mv|rm):*' \
  fzf-preview "$_ftp"

# ── Catch-all ─────────────────────────────────────────────────────────────────
zstyle ':fzf-tab:complete:*:*' fzf-preview "$_ftp"

# ── Editors ───────────────────────────────────────────────────────────────────
zstyle ':fzf-tab:complete:(nvim|vim|vi|nano|hx|code|emacs):*' fzf-preview \
  'bat --style=numbers,changes --color=always --line-range=:300 $realpath 2>/dev/null || cat $realpath'

# ── Git ───────────────────────────────────────────────────────────────────────
zstyle ':fzf-tab:complete:git-(add|diff|restore|checkout|reset|rm):*' fzf-preview \
  'git diff --color=always -- $word 2>/dev/null | delta 2>/dev/null \
  || git diff --color=always -- $word 2>/dev/null \
  || bat --style=numbers,changes --color=always $realpath 2>/dev/null'

zstyle ':fzf-tab:complete:git-log:*' fzf-preview \
  'git log --color=always --oneline --graph --decorate $word 2>/dev/null'

zstyle ':fzf-tab:complete:git-show:*' fzf-preview \
  'case "$group" in
     "commit tag") git show --color=always $word ;;
     *) git show --color=always $word | delta 2>/dev/null || git show --color=always $word ;;
   esac'

zstyle ':fzf-tab:complete:git-checkout:*' fzf-preview \
  'case "$group" in
     "modified file")
       git diff --color=always $word | delta 2>/dev/null || git diff --color=always $word ;;
     "recent commit object name")
       git show --color=always $word | delta 2>/dev/null ;;
     *)
       git log --color=always --oneline --graph $word ;;
   esac'

zstyle ':fzf-tab:complete:git-help:*' fzf-preview \
  'git help $word 2>/dev/null | bat --language=man --style=plain --color=always 2>/dev/null | head -80'

# ── Systemd ───────────────────────────────────────────────────────────────────
zstyle ':fzf-tab:complete:(systemctl|sc-*|journalctl):*' fzf-preview \
  'SYSTEMD_COLORS=1 systemctl status --no-pager $word 2>/dev/null'

# ── Processes ─────────────────────────────────────────────────────────────────
zstyle ':fzf-tab:complete:kill:argument-rest' fzf-preview \
  'ps --pid=$word -o pid,user,comm,args --no-headers -w -w 2>/dev/null'
zstyle ':fzf-tab:complete:kill:argument-rest' fzf-flags '--preview-window=down:5:wrap'

# ── Man pages ─────────────────────────────────────────────────────────────────
zstyle ':fzf-tab:complete:(\\|*/|)man:*' fzf-preview \
  'man $word 2>/dev/null | head -60 | bat --language=man --style=plain --color=always 2>/dev/null'

# ── Environment variables ─────────────────────────────────────────────────────
zstyle ':fzf-tab:complete:(-command-|-parameter-|-brace-parameter-|export|unset|expand):*' \
  fzf-preview 'echo ${(P)word}'

# ── Docker ────────────────────────────────────────────────────────────────────
zstyle ':fzf-tab:complete:docker-(run|pull|push|tag|rmi|inspect):*' fzf-preview \
  'docker inspect $word 2>/dev/null | bat --language=json --color=always | head -80'

# ── Pacman / AUR helpers ──────────────────────────────────────────────────────
# Separate entries per helper (not alternation): zstyle pattern matching with
# alternation is not guaranteed across zsh versions.
# No yay/paru -Si in preview: AUR HTTPS calls on every cursor movement
# (potentially dozens/sec) would saturate the network. pacman -Si reads
# /var/lib/pacman/sync/ locally in ~5ms.
_pac_preview='
  p="${word%%[[:space:]]*}"
  p="${p%%[[:space:]]──*}"
  if info=$(pacman -Si "$p" 2>/dev/null); then
    printf "%s\n" "$info"
    printf "\n\033[2m── Files (head 20) ──────────────────────────────────\033[0m\n"
    pacman -Fl "$p" 2>/dev/null | awk "{print \$2}" | head -20
  elif info=$(pacman -Qi "$p" 2>/dev/null); then
    printf "%s\n" "$info"
    printf "\n\033[2m── Installed files (head 20) ────────────────────────\033[0m\n"
    pacman -Ql "$p" 2>/dev/null | awk "{print \$2}" | head -20
  else
    printf "\033[2m(AUR-only — not in sync/local DB)\033[0m\n"
    printf "Run: yay -Si %s\n" "$p"
  fi
'
zstyle ':fzf-tab:complete:pacman:*' fzf-preview "$_pac_preview"
zstyle ':fzf-tab:complete:yay:*'    fzf-preview "$_pac_preview"
zstyle ':fzf-tab:complete:paru:*'   fzf-preview "$_pac_preview"
zstyle ':fzf-tab:complete:pikaur:*' fzf-preview "$_pac_preview"
unset _pac_preview

# ── pip ───────────────────────────────────────────────────────────────────────
zstyle ':fzf-tab:complete:pip(|3):*' fzf-preview \
  'pip show $word 2>/dev/null | bat --language=yaml --color=always'

# ── cargo ─────────────────────────────────────────────────────────────────────
zstyle ':fzf-tab:complete:cargo:*' fzf-preview \
  'cargo info $word 2>/dev/null | head -30'

# ── Flatpak ───────────────────────────────────────────────────────────────────
zstyle ':fzf-tab:complete:flatpak:*' fzf-preview \
  'flatpak info $word 2>/dev/null | head -40'

# ── SSH ───────────────────────────────────────────────────────────────────────
zstyle ':fzf-tab:complete:ssh:*' fzf-preview \
  'grep -A5 "Host[[:space:]]*$word" ~/.ssh/config 2>/dev/null | head -12'

# ── Network interfaces ────────────────────────────────────────────────────────
zstyle ':fzf-tab:complete:ip:*' fzf-preview \
  'ip addr show $word 2>/dev/null || ip link show $word 2>/dev/null'

# ── mise ──────────────────────────────────────────────────────────────────────
zstyle ':fzf-tab:complete:mise:*' fzf-preview \
  'mise info $word 2>/dev/null | head -30'

unset _ftp