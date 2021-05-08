# Zstyles

zstyle ':completion:*:*:cdr:*:*' menu selection # Ref. https://man.archlinux.org/man/zshcontrib.1#REMEMBERING_RECENT_DIRECTORIES
zstyle ':completion:*' menu select # select completions with arrow keys
zstyle ':completion:*' group-name '' # group results by category
zstyle ':completion:*' rehash true # enable rehash
zstyle ':completion:::::' completer _expand _complete _ignored _approximate # enable approximate matches for completion
