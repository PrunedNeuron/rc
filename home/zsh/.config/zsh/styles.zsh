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

zstyle ':completion::complete:*' use-cache 1
zstyle ':completion::complete:*' cache-path $ZCACHEDIR

# Real time type-ahead autocomplete configuration | Using marlonrichert/zsh-autocomplete
# The code below sets all of `zsh-autocomplete`'s settings to their default
# values. To change a setting, copy it into your `.zshrc` file.
zstyle ':autocomplete:*' min-input 2 # $int chars
zstyle ':autocomplete:*' fzf-completion yes
zstyle ':autocomplete:*' widget-style menu-select 
zstyle ':autocomplete:*' list-lines 512
zstyle ':autocomplete:history-search:*' list-lines 512

# Number of history lines (integer) when pressing ⌃R or ⌃S.
zstyle ':autocomplete:history-incremental-search-*:*' list-lines 512

