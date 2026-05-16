# core/completion.zsh — zstyle configuration for the completion system.
# MUST be sourced before compinit (which fires inside ZIM_HOME/init.zsh).

# ── Cache ─────────────────────────────────────────────────────────────────────
zstyle ':completion::complete:*' use-cache  1
zstyle ':completion::complete:*' cache-path "$ZCACHEDIR"
zstyle ':zim:completion'         dumpfile   "$ZCACHEDIR/.zcompdump"

# ── Core behaviour ────────────────────────────────────────────────────────────
# menu=no is MANDATORY: fzf-tab intercepts the menu before it is drawn.
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
# _expand_alias is intentionally absent: it returns success with 0 candidates,
# causing fzf-tab to open an empty popup before _complete even runs.
# zsh-abbr handles abbreviation expansion at the ZLE layer independently.
zstyle ':completion:*' completer _complete _ignored _approximate
zstyle ':completion:*:approximate:*' max-errors 1 numeric
zstyle ':completion:*:match:*'       original   only

# ── Matching: case-insensitive, partial-word, substring ───────────────────────
zstyle ':completion:*' matcher-list \
  'm:{a-z}={A-Z}' \
  'm:{a-zA-Z}={A-Za-z}' \
  'r:|[._-]=* r:|=*' \
  'l:|=* r:|=*'

# ── Display format ────────────────────────────────────────────────────────────
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
zstyle ':completion:*'                        list-dirs-first   true
zstyle ':completion:*'                        accept-exact-dirs true
zstyle ':completion:*:*:cd:*:directory-stack' force-list        always
zstyle ':completion:*:*:cd:*:directory-stack' menu              yes select
zstyle ':completion:*:git-checkout:*'         sort              false

# ── Process completion ────────────────────────────────────────────────────────
zstyle ':completion:*:*:*:*:processes' force-list  always
zstyle ':completion:*:*:*:*:processes' menu        yes select
zstyle ':completion:*:*:*:*:processes' list-colors '=(#b) #([0-9]#) ([0-9a-z-]#)*=01;34=0=01'
zstyle ':completion:*:*:*:*:processes' command     "ps -u $USER -o pid,user,args -w -w"

# ── LS_COLORS (applied after vivid generates them in tools/env.zsh) ───────────
# sched 0 fires after the current event loop cycle, by which point LS_COLORS is set.
_apply_list_colors() {
  zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
  unfunction _apply_list_colors
}
sched 0 _apply_list_colors

# ── Miscellaneous ─────────────────────────────────────────────────────────────
zstyle ':completion:*' hosts 'reply=()'   # disable slow DNS host completion
zstyle ':completion:*:git-*'    verbose    true
zstyle ':completion:*:carapace:*' group-name ''

# ── Package completion TTL (24-hour cache) ────────────────────────────────────
_pkg_cache_policy() { local -a old=("$1"(Nmh+24)); (( ${#old} )) }
for _cpm in pacman yay paru pikaur trizen; do
  zstyle ":completion:*:${_cpm}:*" cache-policy _pkg_cache_policy
done
unset _cpm