# Keybindings

# Cursor type
echo -ne "\e]50;CursorShape=2\a" # Underline

bindkey "^Q" push-line-or-edit
bindkey "^N" insert-last-word
bindkey "^Y" accept-and-hold

# History nav vertical
bindkey '^[[A' history-substring-search-up
bindkey '^[[B' history-substring-search-down

# Delete char
bindkey '^[[3~' delete-char

# Ctrl+Left, Ctrl+Right
bindkey '^[[1;5D' backward-word
bindkey '^[[1;5C' forward-word

# Ctrl+Backspace, Ctrl+Delete
bindkey '^[[3;5~' kill-word
bindkey '^H' backward-kill-word # doesn't work anymore for some reason

# Movement
bindkey '^A' beginning-of-line
bindkey '^E' end-of-line
bindkey "^K" kill-line

### Program specific
# fzf
# bindkey '^T' fzf-completion
# zle     -N     fzf-history-widget-accept
# bindkey '^X^R' fzf-history-widget-accept

## marlonrichert/zsh-autocomplete
# Up arrow:
bindkey '\e[A' up-line-or-search
bindkey '\eOA' up-line-or-search
# up-line-or-search:  Open history menu.
# up-line-or-history: Cycle to previous history line.

# Down arrow:
bindkey '\e[B' down-line-or-select
bindkey '\eOB' down-line-or-select
# down-line-or-select:  Open completion menu.
# down-line-or-history: Cycle to next history line.

# Control-Space:
bindkey '\0' list-expand
# list-expand:      Reveal hidden completions.
# set-mark-command: Activate text selection.

### Misc / Non-essential
# Load widgets with their keybindings
source <(cat $(ls -1 $ZCONFDIR/widgets/**/*))
