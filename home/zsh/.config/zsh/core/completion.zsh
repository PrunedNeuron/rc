# core/completion.zsh — zstyle configuration for Zsh's completion system.
# Intentionally sourced twice:
#   1. before Zim, so cache/dumpfile settings are visible to compinit;
#   2. after Zim, because Zim's completion module installs its own zstyles and
#      would otherwise override our fzf-tab-compatible runtime policy.
# Everything in this file is idempotent.

# ══════════════════════════════════════════════════════════════════════════════
# Cache
# ══════════════════════════════════════════════════════════════════════════════
zstyle ':completion::complete:*' use-cache yes
zstyle ':completion::complete:*' cache-path "$ZCACHEDIR"
zstyle ':zim:completion' dumpfile "$ZCACHEDIR/.zcompdump"

# ══════════════════════════════════════════════════════════════════════════════
# Core behaviour
# ══════════════════════════════════════════════════════════════════════════════
# fzf-tab needs the normal Zsh menu suppressed so it can own selection.
zstyle ':completion:*' menu no

# Preserve named groups; fzf-tab turns these into group headers.
zstyle ':completion:*' group-name ''

# Deterministic command-position grouping without imposing irrelevant groups on
# every other completion context.
zstyle ':completion:*:*:-command-:*:*' group-order \
  aliases functions builtins reserved-words commands

# Useful behaviour retained from the original configuration.
zstyle ':completion:*' gain-privileges yes
zstyle ':completion:*' list-dirs-first true
zstyle ':completion:*' accept-exact-dirs true
zstyle ':completion:*:git-checkout:*' sort false

# ══════════════════════════════════════════════════════════════════════════════
# Completer pipeline
# ══════════════════════════════════════════════════════════════════════════════
# Fast/normal completion first, then ignored candidates, then one-error typo
# recovery. _expand_alias stays absent because zsh-abbr owns abbreviation
# expansion at the ZLE layer.
zstyle ':completion:*' completer _complete _ignored _approximate
zstyle ':completion:*:approximate:*' max-errors 1 numeric
zstyle ':completion:*:match:*' original only

# ══════════════════════════════════════════════════════════════════════════════
# Matching
# ══════════════════════════════════════════════════════════════════════════════
# Each matcher-list entry is a fresh completion pass. Keep the progression
# compact while preserving case-insensitive, partial-word and substring search.
# Start with Zim's Zsh-5.9-safe smart-case matcher, then progressively
# broaden the same matcher with separator-aware and substring matching.
zstyle ':completion:*' matcher-list \
  'm:{[:lower:]}={[:upper:]}' \
  '+r:|[._-]=* r:|=*' \
  '+l:|=*'

# ══════════════════════════════════════════════════════════════════════════════
# Presentation
# ══════════════════════════════════════════════════════════════════════════════
# fzf-tab requires a plain description format for group support.
zstyle ':completion:*:descriptions' format '[%d]'
zstyle ':completion:*:corrections'  format '%U%F{green}%d (errors: %e)%f%u'
zstyle ':completion:*:warnings'     format '%F{202}%BSorry, no matches for: %F{214}%d%b'
zstyle ':completion:*:messages'     format '%F{yellow}%d%f'

# LS_COLORS is already established by tools/env.zsh before this file is sourced.
if [[ -n ${LS_COLORS-} ]]; then
  zstyle ':completion:*'         list-colors ${(s.:.)LS_COLORS}
  zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}
fi

# ══════════════════════════════════════════════════════════════════════════════
# Ignored candidates
# ══════════════════════════════════════════════════════════════════════════════
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

# ══════════════════════════════════════════════════════════════════════════════
# Directory/process completion
# ══════════════════════════════════════════════════════════════════════════════
# Zim installs a more-specific `menu yes select` for directory-stack and
# history-word completion. Those would beat the global `menu no`, so explicitly
# neutralize them for fzf-tab as well.
zstyle ':completion:*:*:cd:*:directory-stack' menu no
zstyle ':completion:*:history-words' menu no

# Force candidate generation, but never turn the native menu selector back on.
zstyle ':completion:*:*:cd:*:directory-stack' force-list always
zstyle ':completion:*:*:*:*:processes' force-list always
zstyle ':completion:*:*:*:*:processes' list-colors \
  '=(#b) #([0-9]#) ([0-9a-z-]#)*=01;34=0=01'
zstyle ':completion:*:*:*:*:processes' command \
  'ps -u $USER -o pid,user,args -w -w'

# ══════════════════════════════════════════════════════════════════════════════
# Application-specific behaviour
# ══════════════════════════════════════════════════════════════════════════════
zstyle ':completion:*:git-*' verbose true
zstyle ':completion:*:carapace:*' group-name ''

# Do NOT globally blank the `hosts` style. Zsh can complete SSH hosts from
# ~/.ssh/config, known_hosts and /etc/hosts without performing a DNS zone walk.

# ══════════════════════════════════════════════════════════════════════════════
# Package completion cache policy — 24 hours
# ══════════════════════════════════════════════════════════════════════════════
_pkg_cache_policy() {
  local -a stale=("$1"(Nmh+24))
  (( ${#stale} ))
}

for _completion_pm in pacman yay paru pikaur trizen; do
  zstyle ":completion:*:${_completion_pm}:*" cache-policy _pkg_cache_policy
done
unset _completion_pm
