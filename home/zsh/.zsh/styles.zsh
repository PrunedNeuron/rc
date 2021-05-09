# Zstyles

# Completion
zstyle ':completion:*:*:cdr:*:*' menu selection # Ref. https://man.archlinux.org/man/zshcontrib.1#REMEMBERING_RECENT_DIRECTORIES
zstyle ':completion:*' menu select # select completions with arrow keys
zstyle ':completion:*' group-name '' # group results by category
zstyle ':completion:*' rehash true # enable rehash
zstyle ':completion:::::' completer _expand _complete _ignored _approximate # enable approximate matches for completion

## Real time type-ahead autocomplete configuration | Using marlonrichert/zsh-autocomplete
# -> Min input to start autocompletion
zstyle ':autocomplete:*' min-input 2

# -> If any of the following are shown at the same time,
# list them in the order given,
zstyle ':completion:*:' group-order \
    expansions history-words options \
    aliases functions executables \
    local-directories directories suffix-aliases \
    reserved-words builtins

## fzf styles
# Use fzf for completion
#zstyle ':autocomplete:tab:*' fzf-completion yes

# disable sort when completing `git checkout`
zstyle ':completion:*:git-checkout:*' sort false

# set descriptions format to enable group support
zstyle ':completion:*:descriptions' format '[%d]'

# set list-colors to enable filename colorizing
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}

# preview directory's content with exa when completing cd
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'exa -1 --color=always $realpath'

# switch group using `,` and `.`
zstyle ':fzf-tab:*' switch-group ',' '.'

# switch group using `,` and `.`
zstyle ':fzf-tab:*' fzf-command ftb-tmux-popup

zstyle ':fzf-tab:complete:cd:*' fzf-preview 'exa -1 --color=always $realpath'
zstyle ':fzf-tab:complete:cd:*' popup-pad 30 0
