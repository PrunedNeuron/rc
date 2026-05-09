# $ZCONFDIR/styles.zsh — zstyle for completion and fzf-tab.
# Sourced BEFORE compinit (which runs inside init/post.zsh).

# ══════════════════════════════════════════════════════════════════════════════
# Standard zsh completion
# ══════════════════════════════════════════════════════════════════════════════

# ── Caching ───────────────────────────────────────────────────────────────────
zstyle ':completion::complete:*' use-cache    1
zstyle ':completion::complete:*' cache-path   "$ZCACHEDIR"
zstyle ':zim:completion'         dumpfile     "$ZCACHEDIR/.zcompdump"

# ── Core behaviour ────────────────────────────────────────────────────────────
# 'menu no' is mandatory: fzf-tab intercepts before the menu is drawn.
zstyle ':completion:*' menu              no
zstyle ':completion:*' group-name        ''
zstyle ':completion:*' show-completer    true
zstyle ':completion:*' gain-privileges   1

zstyle ':completion:*:' group-order \
  expansions history-words options \
  aliases functions executables \
  local-directories directories suffix-aliases \
  reserved-words builtins

# ── Completer pipeline ────────────────────────────────────────────────────────
# _expand_alias is absent: it signals success (0 candidates) which causes
# fzf-tab to open an empty popup before _complete even runs.
# zsh-abbr handles abbreviation expansion at the ZLE layer independently.
zstyle ':completion:*' completer _complete _ignored _approximate
zstyle ':completion:*:approximate:*' max-errors 1 numeric
zstyle ':completion:*:match:*'       original   only

# ── Matching ─────────────────────────────────────────────────────────────────
zstyle ':completion:*' matcher-list \
  'm:{a-z}={A-Z}' \
  'm:{a-zA-Z}={A-Za-z}' \
  'r:|[._-]=* r:|=*' \
  'l:|=* r:|=*'

# ── Descriptions ──────────────────────────────────────────────────────────────
zstyle ':completion:*:descriptions' format '[%d]'
zstyle ':completion:*:corrections'  format '%U%F{green}%d (errors: %e)%f%u'
zstyle ':completion:*:warnings'     format '%F{202}%BSorry, no matches for: %F{214}%d%b'
zstyle ':completion:*:messages'     format '%F{yellow}%d%f'

# ── Ignored patterns ──────────────────────────────────────────────────────────
zstyle ':completion:*:functions' ignored-patterns '(_*|pre(cmd|exec)|TRAP*)'
zstyle ':completion:*:*:*:users' ignored-patterns \
  adm amanda apache at avahi avahi-autoipd bin cacti canna clamav daemon \
  dbus distcache dnsmasq dovecot fax ftp games gdm gkrellmd gopher hacluster \
  haldaemon halt hsqldb ident junkbust kdm ldap lp mail mailman mailnull \
  man messagebus mldonkey mysql nagios named netdump news nfsnobody nobody \
  nscd ntp nut nx obsrun openvpn operator pcap polkitd postfix postgres \
  privoxy pulse pvm quagga radvd rpc rpcuser rpm rtkit scard shutdown squid \
  sshd statd svn sync tftp usbmux uucp vcsa wwwrun xfs cron mongodb \
  nullmail portage redis shoutcast tcpdump '_*'

# ── Directory completion ──────────────────────────────────────────────────────
zstyle ':completion:*'                    list-dirs-first   true
zstyle ':completion:*'                    accept-exact-dirs true
zstyle ':completion:*:*:cd:*:directory-stack' force-list   always
zstyle ':completion:*:*:cd:*:directory-stack' menu         yes select
zstyle ':completion:*:git-checkout:*'     sort              false

# ── Process completion ────────────────────────────────────────────────────────
zstyle ':completion:*:*:*:*:processes' force-list  always
zstyle ':completion:*:*:*:*:processes' menu        yes select
zstyle ':completion:*:*:*:*:processes' list-colors '=(#b) #([0-9]#) ([0-9a-z-]#)*=01;34=0=01'
zstyle ':completion:*:*:*:*:processes' command     "ps -u $USER -o pid,user,args -w -w"

# ── LS_COLORS ─────────────────────────────────────────────────────────────────
_set_list_colors() {
  zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
  unfunction _set_list_colors
}
sched 0 _set_list_colors

# ── Misc ──────────────────────────────────────────────────────────────────────
zstyle ':completion:*' hosts 'reply=()'

# ── Package completion cache (24-hour TTL) ────────────────────────────────────
_pkg_cache_policy() { local -a old=("$1"(Nmh+24)); (( ${#old} )) }
for _pm in pacman yay paru pikaur trizen; do
  zstyle ":completion:*:${_pm}:*" cache-policy _pkg_cache_policy
done
unset _pm

# list-separator for pacman/yay is intentionally NOT set.
# When list-separator is active, fzf-tab receives display strings like
# "vim ── Modern editor" and $word inherits the full string. `pacman -Si`
# then receives "vim ── Modern editor" as its argument and fails silently.
# The preview pane already shows descriptions, so the separator is redundant.

# ── git subcommands ───────────────────────────────────────────────────────────
zstyle ':completion:*:git-*' verbose true

# ── carapace ─────────────────────────────────────────────────────────────────
zstyle ':completion:*:carapace:*' group-name ''

# ══════════════════════════════════════════════════════════════════════════════
# fzf-tab
# ══════════════════════════════════════════════════════════════════════════════
#
# MULTISELECT (all fzf-tab popups):
#   Ctrl+Space   toggle-mark + move down     (inherited from FZF_DEFAULT_OPTS)
#   Ctrl+A       toggle-all                  (inherited from FZF_DEFAULT_OPTS)
#   Tab          accept + insert all marked
#   Shift+Tab    navigate up
#
# PACKAGE COMPLETION IS AUTOMATIC:
#   `pacman -S vim<Tab>` → _pacman completion → fzf-tab popup + preview.
#   No manual invocation. pai/par/etc. are standalone operation helpers.
#
# Run `build-fzf-tab-module` once after install to compile the binary
# LS_COLORS module (replaces the slow pure-zsh fallback).

zstyle ':fzf-tab:*' use-fzf-default-opts yes

# ── Core fzf-tab flags ────────────────────────────────────────────────────────
# --style=default  Overrides global --style=full. Each inner border (list,
#   input, header) costs ~1 line of height; in a 70% popup that's already
#   tight, three extra borders shrink the item list area materially. The outer
#   rounded border from --border=rounded in FZF_DEFAULT_OPTS is preserved.
#
# --exit-0  Exits immediately (code 1, no popup) when stdin is empty. fzf-tab
#   treats non-zero exit as "fall back to standard zsh". Fixes the blank-popup
#   symptom when completion returns 0 candidates for any reason.
#
# --select-1 is ABSENT by design. With it, a completion narrowed to a single
#   candidate (e.g., `pacman -S vim<Tab>` matching only "vim") auto-accepts
#   silently — the preview/info pane never renders. Users pressing Tab to
#   inspect packages need to see the popup even for single matches.
zstyle ':fzf-tab:*' fzf-flags \
  '--height=70%'    \
  '--min-height=16' \
  '--multi'         \
  '--style=default' \
  '--exit-0'        \
  '--bind=tab:accept' \
  '--bind=btab:up'

# ── Global fzf-tab action bindings ───────────────────────────────────────────
zstyle ':fzf-tab:*' fzf-bindings \
  'ctrl-e:execute-silent({_FTB_INIT_}${EDITOR:-nvim} "$realpath" </dev/tty >/dev/tty)' \
  'ctrl-y:execute-silent({_FTB_INIT_}wl-copy -- "$realpath" 2>/dev/null || xclip -selection clipboard -- "$realpath" 2>/dev/null)'

zstyle ':fzf-tab:*' switch-group       '<' '>'
zstyle ':fzf-tab:*' continuous-trigger '/'
zstyle ':fzf-tab:*' show-group         full
zstyle ':fzf-tab:*' popup-min-size     80 16

# ── Shared file/dir preview ───────────────────────────────────────────────────
_ftp='
  if [[ -d $realpath ]]; then
    eza --tree --level=2 --color=always --icons=auto "$realpath" 2>/dev/null \
      || ls -la "$realpath"
  else
    bat --style=numbers,changes --color=always --line-range=:200 "$realpath" 2>/dev/null \
      || cat "$realpath"
  fi
'

# ── Directories & files ───────────────────────────────────────────────────────
zstyle ':fzf-tab:complete:cd:*' fzf-preview \
  'eza --tree --level=2 --color=always --icons=auto $realpath 2>/dev/null || ls -la $realpath'
zstyle ':fzf-tab:complete:cd:*' popup-min-size 60 16

zstyle ':fzf-tab:complete:(ls|eza|exa|lsd|stat|file|wc|head|tail|diff|patch|cp|mv|rm):*' \
  fzf-preview "$_ftp"

# Catch-all: preview for any command not explicitly configured.
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

# ── Pacman / yay / paru / pikaur ─────────────────────────────────────────────
#
# Design decisions:
#
# (a) Separate entries per tool — not `(pacman|yay|paru)` alternation.
#     Alternation in zstyle patterns relies on EXTENDED_GLOB and zstyle's
#     internal pattern-matching implementation. Behaviour is not guaranteed
#     across zsh versions. Separate entries are unambiguous.
#
# (b) No `yay -Si` / `paru -Si` in the preview.
#     Both make AUR API calls over HTTPS. A preview re-executes on every
#     cursor movement — dozens of HTTP requests per second. `pacman -Si`
#     reads /var/lib/pacman/sync/ locally and returns in ~5ms.
#
# (c) $word cleaning before passing to pacman.
#     Defensive strip of any trailing whitespace and separator artifacts.
#     `"${word%%[[:space:]]*}"` handles both. This ensures correctness
#     across fzf-tab versions regardless of how $word is populated.
#
# (d) File list appended below the info block.
#     `pacman -Fl` (sync) / `pacman -Ql` (local) shows installed files,
#     which is useful when choosing between packages with similar names.

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
