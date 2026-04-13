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
# 'menu no' is required for fzf-tab to capture the unambiguous prefix
zstyle ':completion:*' menu              no
zstyle ':completion:*' group-name        ''
zstyle ':completion:*' show-completer    true
zstyle ':completion:*' gain-privileges   1        # sudo-aware completions

# Group order: expansions first, then options, then files
zstyle ':completion:*:' group-order \
  expansions history-words options \
  aliases functions executables \
  local-directories directories suffix-aliases \
  reserved-words builtins

# ── Matching — progressive four-stage fallback ────────────────────────────────
zstyle ':completion:*' completer _complete _ignored _approximate
zstyle ':completion:*:approximate:*' max-errors 1 numeric
zstyle ':completion:*:match:*'       original   only
zstyle ':completion:*' matcher-list \
  'm:{a-z}={A-Z}' \
  'm:{a-zA-Z}={A-Za-z}' \
  'r:|[._-]=* r:|=*' \
  'l:|=* r:|=*'

# ── Descriptions ──────────────────────────────────────────────────────────────
# Do NOT use %F{colour} here — fzf-tab silently ignores escape sequences.
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
zstyle ':completion:*'                    list-dirs-first  true
zstyle ':completion:*'                    accept-exact-dirs true
zstyle ':completion:*:*:cd:*:directory-stack' force-list  always
zstyle ':completion:*:*:cd:*:directory-stack' menu        yes select
zstyle ':completion:*:git-checkout:*'     sort             false

# ── Process completion ────────────────────────────────────────────────────────
zstyle ':completion:*:*:*:*:processes' force-list  always
zstyle ':completion:*:*:*:*:processes' menu        yes select
zstyle ':completion:*:*:*:*:processes' list-colors '=(#b) #([0-9]#) ([0-9a-z-]#)*=01;34=0=01'
zstyle ':completion:*:*:*:*:processes' command     "ps -u $USER -o pid,user,args -w -w"

# ── LS_COLORS ─────────────────────────────────────────────────────────────────
# Scheduled after startup so LS_COLORS is fully populated by vivid/dircolors
_set_list_colors() {
  zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
  unfunction _set_list_colors
}
sched 0 _set_list_colors

# ── Misc ──────────────────────────────────────────────────────────────────────
zstyle ':completion:*' hosts 'reply=()'   # skip slow /etc/hosts lookup

# ── Allow searching display strings (group headers, descriptions) in fzf-tab ─
zstyle ':completion:*' fzf-search-display true

# ── Package completion cache policy (24-hour TTL) ─────────────────────────────
# Without a policy, caches are permanent but the first completion in a new shell
# that hasn't warmed yet queries pacman -Slq (~16k packages) synchronously.
# A 24h TTL ensures stale caches auto-refresh while avoiding per-shell queries.
# Glob qualifier: Nmh+24 = files with mtime > 24 hours ago.
_pkg_cache_policy() { local -a old=("$1"(Nmh+24)); (( ${#old} )) }

zstyle ':completion:*:pacman:*'  cache-policy _pkg_cache_policy
zstyle ':completion:*:yay:*'     cache-policy _pkg_cache_policy
zstyle ':completion:*:paru:*'    cache-policy _pkg_cache_policy
zstyle ':completion:*:pikaur:*'  cache-policy _pkg_cache_policy
zstyle ':completion:*:trizen:*'  cache-policy _pkg_cache_policy

# ── Show package descriptions alongside names in completion list ───────────────
# Forces _pacman/_yay to include the description field in the display string,
# making it readable inside fzf-tab without opening the preview pane.
zstyle ':completion:*:pacman:option-S-1:*' list-separator '──'
zstyle ':completion:*:yay:option-S-1:*'    list-separator '──'

# ── Completion: always expand aliases in completion context ───────────────────
zstyle ':completion:*' completer _expand_alias _complete _ignored _approximate

# ── git: show description of subcommands ──────────────────────────────────────
zstyle ':completion:*:git-*' verbose true

# ── Show hidden files in completion (fd/rg don't need this; zsh built-ins do) ─
zstyle ':completion:*' file-patterns \
  '%p(^-/):globbed-files *(-/):directories' \
  '*:all-files'

# ── carapace: use dimmed group format that matches our style ──────────────────
# This only applies when carapace is active (loaded in plugins.zsh).
zstyle ':completion:*:carapace:*' group-name ''

# ══════════════════════════════════════════════════════════════════════════════
# fzf-tab
# ══════════════════════════════════════════════════════════════════════════════
#
# Variable reference (always single-quote — evaluated at completion time):
#   $realpath  absolute path of candidate (file/dir completions)
#   $word      raw candidate string (git refs, package names, etc.)
#   $group     current completion group (git-checkout context switching)
#
# MULTISELECT: With --multi in fzf-flags:
#   Ctrl+Space  toggle-mark current item and move down  (from FZF_DEFAULT_OPTS)
#   Ctrl+A      toggle-all                               (from FZF_DEFAULT_OPTS)
#   Tab         accept + insert all marked items
#   Shift+Tab   navigate up
# Example: `git add <Tab>` → Ctrl+Space to mark multiple files → Tab to stage all
#
# PERFORMANCE: Run `build-fzf-tab-module` once after install to compile the
# binary LS_COLORS module, replacing the slow pure-zsh fallback.

# ── Inherit FZF_DEFAULT_OPTS ──────────────────────────────────────────────────
# Caveats: --height is silently ignored when inherited; repeat in fzf-flags.
# --bind=tab:accept in FZF_DEFAULT_OPTS would break continuous-trigger — never.
zstyle ':fzf-tab:*' use-fzf-default-opts yes

# ── Core fzf-tab flags ────────────────────────────────────────────────────────
# --multi   enables Ctrl+Space multi-select (binds from FZF_DEFAULT_OPTS apply)
# tab:accept  accept the selection (with --multi, inserts ALL marked items)
# btab:up     Shift+Tab navigates up without accepting
zstyle ':fzf-tab:*' fzf-flags \
  '--height=65%'    \
  '--min-height=12' \
  '--multi'         \
  '--bind=tab:accept' \
  '--bind=btab:up'

# ── Global fzf-tab bindings (use {_FTB_INIT_} to access $realpath/$word) ─────
# These allow acting on completion candidates without leaving the menu.
zstyle ':fzf-tab:*' fzf-bindings \
  'ctrl-e:execute-silent({_FTB_INIT_}${EDITOR:-nvim} "$realpath" </dev/tty >/dev/tty)' \
  'ctrl-y:execute-silent({_FTB_INIT_}wl-copy -- "$realpath" 2>/dev/null || xclip -selection clipboard -- "$realpath" 2>/dev/null)'

zstyle ':fzf-tab:*' switch-group       '<' '>'
zstyle ':fzf-tab:*' continuous-trigger '/'
zstyle ':fzf-tab:*' show-group        full
zstyle ':fzf-tab:*' popup-min-size    80 12

# ── Shared file preview (DRY helper) ─────────────────────────────────────────
_ftp='
  if [[ -d $realpath ]]; then
    eza --tree --level=2 --color=always --icons=auto "$realpath" 2>/dev/null || ls -la "$realpath"
  else
    bat --style=numbers,changes --color=always --line-range=:200 "$realpath" 2>/dev/null || cat "$realpath"
  fi
'

# ── Directories & files ───────────────────────────────────────────────────────
zstyle ':fzf-tab:complete:cd:*' fzf-preview \
  'eza --tree --level=2 --color=always --icons=auto $realpath 2>/dev/null || ls -la $realpath'
zstyle ':fzf-tab:complete:cd:*' popup-min-size 60 16

zstyle ':fzf-tab:complete:(ls|eza|exa|lsd|stat|file|wc|head|tail|diff|patch|cp|mv|rm):*' \
  fzf-preview "$_ftp"

# Fallback for every other command with file/dir arguments
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

# ── Pacman / yay / paru ───────────────────────────────────────────────────────
zstyle ':fzf-tab:complete:(pacman|yay|paru):*' fzf-preview \
  'pacman -Si $word 2>/dev/null || pacman -Qi $word 2>/dev/null'

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

unset _ftp
