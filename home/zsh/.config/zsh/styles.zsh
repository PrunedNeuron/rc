# $ZCONFDIR/styles.zsh

# ── Completion caching ────────────────────────────────────────────────────────
zstyle ':completion::complete:*' use-cache 1
zstyle ':completion::complete:*' cache-path "$ZCACHEDIR"
zstyle ':zim:completion'         dumpfile  "$ZCACHEDIR/.zcompdump"

# ── Core completion behaviour ─────────────────────────────────────────────────
# 'menu no' is required for fzf-tab to capture the unambiguous prefix.
zstyle ':completion:*' menu no
zstyle ':completion:*' group-name ''

zstyle ':completion:*:' group-order \
  expansions history-words options \
  aliases functions executables \
  local-directories directories suffix-aliases \
  reserved-words builtins

# ── Matching ──────────────────────────────────────────────────────────────────
zstyle ':completion:*' completer _complete _ignored _approximate
zstyle ':completion:*:approximate:*' max-errors 1 numeric
zstyle ':completion:*:match:*' original only

# Case-insensitive, partial-word, and substring matching (progressive fallback).
zstyle ':completion:*' matcher-list \
  'm:{a-z}={A-Z}' \
  'm:{a-zA-Z}={A-Za-z}' \
  'r:|[._-]=* r:|=*' \
  'l:|=* r:|=*'

# ── Descriptions and formatting ───────────────────────────────────────────────
# fzf-tab uses this format for group headers.
# NOTE: do NOT use %F{color} escape sequences here — fzf-tab will ignore them.
zstyle ':completion:*:descriptions' format '[%d]'
zstyle ':completion:*:corrections'  format '%U%F{green}%d (errors: %e)%f%u'
zstyle ':completion:*:warnings'     format '%F{202}%BSorry, no matches for: %F{214}%d%b'
zstyle ':completion:*' show-completer true

# ── Ignored patterns ─────────────────────────────────────────────────────────
zstyle ':completion:*:functions'    ignored-patterns '(_*|pre(cmd|exec)|TRAP*)'
zstyle ':completion:*:*:*:users'    ignored-patterns \
  adm amanda apache at avahi avahi-autoipd bin cacti canna clamav daemon dbus \
  distcache dnsmasq dovecot fax ftp games gdm gkrellmd gopher hacluster \
  haldaemon halt hsqldb ident junkbust kdm ldap lp mail mailman mailnull man \
  messagebus mldonkey mysql nagios named netdump news nfsnobody nobody nscd \
  ntp nut nx obsrun openvpn operator pcap polkitd postfix postgres privoxy \
  pulse pvm quagga radvd rpc rpcuser rpm rtkit scard shutdown squid sshd statd \
  svn sync tftp usbmux uucp vcsa wwwrun xfs cron mongodb nullmail portage \
  redis shoutcast tcpdump '_*'

# ── Directory completion ──────────────────────────────────────────────────────
zstyle ':completion:*' list-dirs-first true
zstyle ':completion:*' accept-exact-dirs true
zstyle ':completion:*:*:cd:*:directory-stack' force-list always
zstyle ':completion:*:*:cd:*:directory-stack' menu yes select
# Disable sort for git checkout — branch names should stay in recency order.
zstyle ':completion:*:git-checkout:*' sort false

# ── Process completion ────────────────────────────────────────────────────────
zstyle ':completion:*:*:*:*:processes' force-list always
zstyle ':completion:*:*:*:*:processes' menu yes select
zstyle ':completion:*:*:*:*:processes' list-colors '=(#b) #([0-9]#) ([0-9a-z-]#)*=01;34=0=01'
zstyle ':completion:*:*:*:*:processes' command "ps -u $USER -o pid,user,args -w -w"

# ── LS_COLORS ─────────────────────────────────────────────────────────────────
# Deferred via sched 0 so LS_COLORS is fully populated by the time this runs.
_set_list_colors() {
  zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
  unfunction _set_list_colors
}
sched 0 _set_list_colors

# ── Misc ──────────────────────────────────────────────────────────────────────
zstyle ':completion:*' hosts 'reply=()'
zstyle ':completion::complete:*' gain-privileges 1

# ══════════════════════════════════════════════════════════════════════════════
# fzf-tab — global configuration
# ══════════════════════════════════════════════════════════════════════════════
#
# Variable reference (evaluated at completion time, use single quotes):
#   $realpath  — absolute path of the completion candidate (file/dir previews)
#   $word      — raw completion candidate string (non-path lookups, e.g. git)
#   $group     — completion group name (context-switching, e.g. git-checkout)

# ── Inherit global fzf appearance ─────────────────────────────────────────────
# fzf-tab does NOT read FZF_DEFAULT_OPTS by default. This zstyle opts in.
# Known caveats (see plugins.zsh and fzf-tab issues #455, #493, #509):
#   (a) --height from FZF_DEFAULT_OPTS is silently ignored — set it in fzf-flags.
#   (b) --bind=tab:accept in FZF_DEFAULT_OPTS breaks continuous-trigger ('/').
#       That binding lives ONLY in fzf-flags, never in FZF_DEFAULT_OPTS.
#   (c) When using ftb-tmux-popup, this zstyle has no effect (issue #509).
zstyle ':fzf-tab:*' use-fzf-default-opts yes

# ── Completion-specific fzf overrides ─────────────────────────────────────────
# Only flags that DEVIATE from or EXTEND FZF_DEFAULT_OPTS belong here:
#   --height        must be repeated; ignored when inherited from FZF_DEFAULT_OPTS
#   --min-height    floor so very short lists still render usably
#   tab:accept      insert selection — MUST NOT be in FZF_DEFAULT_OPTS
#   btab:up         Shift+Tab navigates up without accepting
zstyle ':fzf-tab:*' fzf-flags \
  '--height=60%'      \
  '--min-height=10'   \
  '--bind=tab:accept' \
  '--bind=btab:up'

zstyle ':fzf-tab:*' switch-group '<' '>'
zstyle ':fzf-tab:*' continuous-trigger '/'
zstyle ':fzf-tab:*' show-group full
zstyle ':fzf-tab:*' popup-min-size 80 12

# ── Directories & files ───────────────────────────────────────────────────────
zstyle ':fzf-tab:complete:cd:*' fzf-preview \
  'eza --tree --level=2 --color=always --icons=auto $realpath 2>/dev/null || ls -la $realpath'
zstyle ':fzf-tab:complete:cd:*' popup-min-size 60 16

zstyle ':fzf-tab:complete:(ls|eza|exa|lsd):*' fzf-preview \
  '[[ -d $realpath ]] && eza --tree --level=2 --color=always --icons=auto $realpath \
  || bat --style=numbers,changes --color=always --line-range=:100 $realpath 2>/dev/null \
  || cat $realpath'

# Fallback for all other commands with file arguments.
zstyle ':fzf-tab:complete:*:*' fzf-preview \
  '[[ -d $realpath ]] && eza --tree --level=2 --color=always --icons=auto $realpath \
  || bat --style=numbers,changes --color=always --line-range=:100 $realpath 2>/dev/null'

# ── Editor ────────────────────────────────────────────────────────────────────
zstyle ':fzf-tab:complete:(nvim|vim|vi|nano|hx):*' fzf-preview \
  'bat --style=numbers,changes --color=always --line-range=:200 $realpath 2>/dev/null \
  || cat $realpath'

# ── Git ───────────────────────────────────────────────────────────────────────
zstyle ':fzf-tab:complete:git-(add|diff|restore|checkout|reset):*' fzf-preview \
  'git diff --color=always -- $word 2>/dev/null | delta 2>/dev/null \
  || git diff --color=always -- $word'

zstyle ':fzf-tab:complete:git-log:*' fzf-preview \
  'git log --color=always --oneline --graph --decorate $word 2>/dev/null'

zstyle ':fzf-tab:complete:git-show:*' fzf-preview \
  'case "$group" in
     "commit tag") git show --color=always $word ;;
     *) git show --color=always $word | delta 2>/dev/null || git show --color=always $word ;;
   esac'

zstyle ':fzf-tab:complete:git-checkout:*' fzf-preview \
  'case "$group" in
     "modified file") git diff --color=always $word | delta 2>/dev/null \
                      || git diff --color=always $word ;;
     "recent commit object name") git show --color=always $word | delta 2>/dev/null ;;
     *) git log --color=always --oneline --graph $word ;;
   esac'

zstyle ':fzf-tab:complete:git-help:*' fzf-preview \
  'git help $word | bat --language=man --style=plain --color=always 2>/dev/null | head -80'

# ── Systemd ───────────────────────────────────────────────────────────────────
zstyle ':fzf-tab:complete:systemctl-*:*' fzf-preview \
  'SYSTEMD_COLORS=1 systemctl status --no-pager $word 2>/dev/null'
zstyle ':fzf-tab:complete:(systemctl|journalctl):*' fzf-preview \
  'SYSTEMD_COLORS=1 systemctl status --no-pager $word 2>/dev/null'

# ── Processes ─────────────────────────────────────────────────────────────────
zstyle ':fzf-tab:complete:kill:argument-rest' fzf-preview \
  'ps --pid=$word -o pid,user,comm,cmd --no-headers -w -w 2>/dev/null'
zstyle ':fzf-tab:complete:kill:argument-rest' fzf-flags \
  '--preview-window=down:4:wrap'

# ── Man pages ─────────────────────────────────────────────────────────────────
zstyle ':fzf-tab:complete:(\\|*/|)man:*' fzf-preview \
  'man $word 2>/dev/null | head -40 \
  | bat --language=man --style=plain --color=always 2>/dev/null \
  || man $word 2>/dev/null | head -40'

# ── Environment variables ─────────────────────────────────────────────────────
zstyle ':fzf-tab:complete:(-command-|-parameter-|-brace-parameter-|export|unset|expand):*' \
  fzf-preview 'echo ${(P)word}'

# ── Docker ────────────────────────────────────────────────────────────────────
zstyle ':fzf-tab:complete:docker-(run|pull|push|tag|rmi):*' fzf-preview \
  'docker inspect $word 2>/dev/null | bat --language=json --color=always | head -60'

# ── pacman / yay ──────────────────────────────────────────────────────────────
zstyle ':fzf-tab:complete:(pacman|yay|paru):*' fzf-preview \
  'pacman -Si $word 2>/dev/null || pacman -Qi $word 2>/dev/null'

# ── SSH hosts ─────────────────────────────────────────────────────────────────
zstyle ':fzf-tab:complete:ssh:*' fzf-preview \
  'cat ~/.ssh/config 2>/dev/null | grep -A5 "Host $word" | head -10'
