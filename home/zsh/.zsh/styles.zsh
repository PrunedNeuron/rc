# Zstyles

# Completion
zstyle ':completion:*:*:cdr:*:*' menu selection # Ref. https://man.archlinux.org/man/zshcontrib.1#REMEMBERING_RECENT_DIRECTORIES
zstyle ':completion:*' menu select # select completions with arrow keys
zstyle ':completion:*' group-name '' # group results by category
zstyle ':completion:*' rehash true # enable rehash
zstyle ':completion:::::' completer _expand _complete _ignored _approximate # enable approximate matches for completion

# -> If any of the following are shown at the same time,
# list them in the order given,
zstyle ':completion:*:' group-order \
    expansions history-words options \
    aliases functions executables \
    local-directories directories suffix-aliases \
    reserved-words builtins

# Real time type-ahead autocomplete configuration | Using marlonrichert/zsh-autocomplete
# The code below sets all of `zsh-autocomplete`'s settings to their default
# values. To change a setting, copy it into your `.zshrc` file.
zstyle ':autocomplete:*' min-input 2  # int
zstyle ':autocomplete:*' insert-unambiguous no
zstyle ':autocomplete:*' widget-style complete-word
# zstyle ':autocomplete:*' fzf-completion no
zstyle ':autocomplete:tab:*' completion fzf
# zstyle ':autocomplete:tab:*' fzf-completion no

## fzf styles
# Use fzf for completion

# use input as query string when completing zlua
# zstyle ':fzf-tab:complete:_zlua:*' query-string input
#
# disable sort when completing `git checkout`
# zstyle ':completion:*:git-checkout:*' sort false
#
# set descriptions format to enable group support
# zstyle ':completion:*:descriptions' format '[%d]'
#
# set list-colors to enable filename colorizing
# zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
#
# preview directory's content with exa when completing cd
# zstyle ':fzf-tab:complete:cd:*' fzf-preview 'exa -1 --color=always $realpath'
#
# switch group using `,` and `.`
# zstyle ':fzf-tab:*' switch-group ',' '.'
#
# enable tmux popup
# zstyle ':fzf-tab:*' fzf-command ftb-tmux-popup
#
# continuous trigger (accept the result and start another completion immediately)
# zstyle ':fzf-tab:*' continuous-trigger '/'
#
# right and bottom padding of the popup window in tmux
# zstyle ':fzf-tab:complete:cd:*' fzf-preview 'exa -1 --color=always $realpath'
# zstyle ':fzf-tab:complete:cd:*' popup-pad 30 0
#
# specifies the key to accept and run a suggestion in one keystroke
# zstyle ':fzf-tab:*' fzf-bindings 'space:accept'
# zstyle ':fzf-tab:*' accept-line enter
