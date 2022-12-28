# Zstyles

# Completion
zstyle ':completion::complete:*' use-cache 1 # Turn on completion caching
zstyle ':completion::complete:*' cache-path $ZCACHEDIR # Completion cache directory
zstyle ':completion:*:*:cdr:*:*' menu selection # Ref. https://man.archlinux.org/man/zshcontrib.1#REMEMBERING_RECENT_DIRECTORIES
zstyle ':completion:*' menu select # select completions with arrow keys
zstyle ':completion:*' group-name '' # group results by category
zstyle ':completion:*' rehash true # enable rehash
zstyle ':completion:*' completer _complete _ignored _approximate # enable approximate matches for completion

# -> If any of the following are shown at the same time,
# list them in the order given,
zstyle ':completion:*:' group-order \
    expansions history-words options \
    aliases functions executables \
    local-directories directories suffix-aliases \
    reserved-words builtins

# Smart matching of dashed values, e.g. f-b matching foo-bar
zstyle ':completion:*' matcher-list 'r:|[._-]=* r:|=*'

# Number of history lines (integer) when pressing ⌃R or ⌃S.
zstyle ':autocomplete:history-incremental-search-*:*' list-lines 512

# ALERT: Lets completion scripts run in sudo
zstyle ':completion::complete:*' gain-privileges 1

# fuzzy matching of completions you mistype them
zstyle ':completion:*:match:*' original only
zstyle ':completion:*:approximate:*' max-errors 1 numeric

# ignore completion functions
zstyle ':completion:*:functions' ignore-patterns '(_*|pre(cmd|exec)|TRAP*)'

# History multi word search
zstyle ":history-search-multi-word" page-size "12"
zstyle ":plugin:history-search-multi-word" clear-on-cancel "yes" # Exit on ctrl-c

# --

# Keep directories and files separated
zstyle ':completion:*' list-dirs-first true

# Don't try parent path completion if the directories exist
zstyle ':completion:*' accept-exact-dirs true

# Always use menu selection for `cd -`
zstyle ':completion:*:*:cd:*:directory-stack' force-list always
zstyle ':completion:*:*:cd:*:directory-stack' menu yes select

# Pretty messages during pagination
zstyle ':completion:*' list-prompt '%SAt %p: Hit TAB for more, or the character to insert%s'
zstyle ':completion:*' select-prompt '%SScrolling active: current selection at %p%s'

# Nicer format for completion messages
zstyle ':completion:*:descriptions' format '%U%B%d%b%u'
zstyle ':completion:*:corrections' format '%U%F{green}%d (errors: %e)%f%u'
zstyle ':completion:*:warnings' format '%F{202}%BSorry, no matches for: %F{214}%d%b'

# Show message while waiting for completion
zstyle ':completion:*' show-completer true

# Prettier completion for processes
zstyle ':completion:*:*:*:*:processes' force-list always
zstyle ':completion:*:*:*:*:processes' menu yes select
zstyle ':completion:*:*:*:*:processes' list-colors '=(#b) #([0-9]#) ([0-9a-z-]#)*=01;34=0=01'
zstyle ':completion:*:*:*:*:processes' command "ps -u $USER -o pid,user,args -w -w"

# Use ls-colors for path completions
function _set-list-colors() {
	zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
	unfunction _set-list-colors
}
sched 0 _set-list-colors  # deferred since LC_COLORS might not be available yet

# Don't complete hosts from /etc/hosts
zstyle -e ':completion:*' hosts 'reply=()'

zstyle ':completion:*:functions' ignored-patterns '(_*|pre(cmd|exec)|TRAP*)'
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

zstyle ':completion:*' single-ignored show

## marlonrichert/zsh-autocomplete
# zstyle ':autocomplete:*' min-input 2
# zstyle ':autocomplete:*' list-lines 32
# zstyle ':autocomplete:history-search:*' list-lines 32
# zstyle ':autocomplete:history-incremental-search-*:*' list-lines 32
# zstyle ':autocomplete:*' recent-dirs zoxide
# zstyle ':autocomplete:*' widget-style menu-select
