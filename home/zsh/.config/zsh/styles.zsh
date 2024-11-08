# $ZCONFDIR/styles.zsh
# Zsh Styles Configuration

# ===========================
# General Completion Settings
# ===========================

# Enable completion caching and set cache path
zstyle ':completion::complete:*' use-cache 1
zstyle ':completion::complete:*' cache-path "$ZCACHEDIR"

# Enable menu selection with arrow keys
zstyle ':completion:*' menu select

# Group completion results by category without names
zstyle ':completion:*' group-name ''

# Enable rehash to update completion functions dynamically
zstyle ':completion:*' rehash true

# Define completers to include complete, ignored, and approximate matches
zstyle ':completion:*' completer _complete _ignored _approximate

# Define the order of completion groups
zstyle ':completion:*:' group-order \
  expansions history-words options \
  aliases functions executables \
  local-directories directories suffix-aliases \
  reserved-words builtins

# ===========================
# Completion Matching
# ===========================

# Enable approximate matching with a maximum of 1 error (numeric)
zstyle ':completion:*:approximate:*' max-errors 1 numeric

# Match original input only for specific completion patterns
zstyle ':completion:*:match:*' original only

# ===========================
# Completion Function Settings
# ===========================

# Ignore specific function patterns during completion
zstyle ':completion:*:functions' ignore-patterns '(_*|pre(cmd|exec)|TRAP*)'

# Ignore specific user patterns during completion
zstyle ':completion:*:*:*:users' ignored-patterns \
  adm amanda apache at avahi avahi-autoipd beaglidx bin cacti canna \
  clamav daemon dbus distcache dnsmasq dovecot fax ftp games gdm \
  gkrellmd gopher hacluster haldaemon halt hsqldb ident junkbust kdm \
  ldap lp mail mailman mailnull man messagebus mldonkey mysql nagios \
  named netdump news nfsnobody nobody nscd ntp nut nx obsrun openvpn \
  operator pcap polkitd postfix postgres privoxy pulse pvm quagga radvd \
  rpc rpcuser rpm rtkit scard shutdown squid sshd statd svn sync tftp \
  usbmux uucp vcsa wwwrun xfs cron mongodb nullmail portage redis \
  shoutcast tcpdump '_*'

# ===========================
# Directory Completion
# ===========================

# Always list directories first in completions
zstyle ':completion:*' list-dirs-first true

# Accept exact directory names without attempting parent path completion
zstyle ':completion:*' accept-exact-dirs true

# Force menu listing and selection for `cd -`
zstyle ':completion:*:*:cd:*:directory-stack' force-list always
zstyle ':completion:*:*:cd:*:directory-stack' menu yes select

# ===========================
# Completion Prompts and Messages
# ===========================

# Customize list prompt during pagination
zstyle ':completion:*' list-prompt '%SAt %p: Hit TAB for more, or the character to insert%s'

# Customize select prompt during active scrolling
zstyle ':completion:*' select-prompt '%SScrolling active: current selection at %p%s'

# Format descriptions, corrections, and warnings with styling
zstyle ':completion:*:descriptions' format '%U%B%d%b%u'
zstyle ':completion:*:corrections' format '%U%F{green}%d (errors: %e)%f%u'
zstyle ':completion:*:warnings' format '%F{202}%BSorry, no matches for: %F{214}%d%b'

# Show a message while waiting for completion
zstyle ':completion:*' show-completer true

# ===========================
# Process Completion Enhancements
# ===========================

# Always list processes and enable menu selection
zstyle ':completion:*:*:*:*:processes' force-list always
zstyle ':completion:*:*:*:*:processes' menu yes select

# Define list colors for process completions
zstyle ':completion:*:*:*:*:processes' list-colors '=(#b) #([0-9]#) ([0-9a-z-]#)*=01;34=0=01'

# Define the command used for fetching process information
zstyle ':completion:*:*:*:*:processes' command "ps -u $USER -o pid,user,args -w -w"

# ===========================
# Custom List Colors
# ===========================

# Apply LS_COLORS to completion listings
_set_list_colors() {
  zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
  unfunction _set_list_colors
}
sched 0 _set_list_colors  # Deferred execution until LS_COLORS is available

# ===========================
# Host and Directory Completion
# ===========================

# Disable host completion from /etc/hosts
zstyle ':completion:*' hosts 'reply=()'

# ===========================
# Completion for History Search
# ===========================

# Configure list lines for history incremental search
zstyle ':autocomplete:history-incremental-search-*:*' list-lines 32

# Configure page size for multi-word history search
zstyle ":history-search-multi-word" page-size 12

# Exit multi-word history search on cancel (Ctrl-C)
zstyle ":plugin:history-search-multi-word" clear-on-cancel yes

# ===========================
# Recent Directories and Widget Style
# ===========================

# Use zoxide for recent directory completions
zstyle ':autocomplete:*' recent-dirs zoxide

# Define widget style as menu-select
zstyle ':autocomplete:*' widget-style menu-select

# ===========================
# Gain Privileges for Completions
# ===========================

# Allow completion scripts to gain elevated privileges when necessary
zstyle ':completion::complete:*' gain-privileges 1
