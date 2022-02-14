# Zstyles

# Completion
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

zstyle ':completion::complete:*' use-cache on
zstyle ':completion::complete:*' cache-path $ZCACHEDIR

# Number of history lines (integer) when pressing ⌃R or ⌃S.
zstyle ':autocomplete:history-incremental-search-*:*' list-lines 512

# ALERT: Lets completion scripts run in sudo
zstyle ':completion::complete:*' gain-privileges 1

# fuzzy matching of completions you mistype them
zstyle ':completion:*' completer _complete _match _approximate
zstyle ':completion:*:match:*' original only
zstyle ':completion:*:approximate:*' max-errors 1 numeric

# ignore completion functions
zstyle ':completion:*:functions' ignore-patterns '_*'
