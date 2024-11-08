# Keybindings

# Ensure the terminal is in application mode when ZLE is active
if (( ${+terminfo[smkx]} )) && (( ${+terminfo[rmkx]} )); then
  function zle-line-init() { echoti smkx }
  function zle-line-finish() { echoti rmkx }
  zle -N zle-line-init
  zle -N zle-line-finish
fi

# Use Emacs key bindings
bindkey -e

# Keymaps to bind keys in
zsh_keymaps=(emacs viins vicmd)

# Function to bind terminfo keys to a widget across multiple keymaps
bind_terminfo_key() {
  local key="$1" widget="$2"
  [[ -n "${terminfo[$key]}" ]] || return
  for map in $zsh_keymaps; do
    bindkey -M "$map" "${terminfo[$key]}" "$widget"
  done
}

# Function to bind a key sequence to a widget across multiple keymaps
bind_key_sequence() {
  local seq="$1" widget="$2"
  for map in $zsh_keymaps; do
    bindkey -M "$map" "$seq" "$widget"
  done
}



# Bind PageUp and PageDown to history navigation
bind_terminfo_key kpp up-line-or-history      # [PageUp]
bind_terminfo_key knp down-line-or-history    # [PageDown]

# Bind Up and Down arrows for fuzzy history search
autoload -Uz up-line-or-beginning-search down-line-or-beginning-search
zle -N up-line-or-beginning-search
zle -N down-line-or-beginning-search

bind_terminfo_key kcuu1 up-line-or-beginning-search   # [Up-Arrow]
bind_terminfo_key kcud1 down-line-or-beginning-search # [Down-Arrow]

# Fallback bindings for Up and Down arrows
bindkey '^[[A' up-line-or-beginning-search
bindkey '^[OA' up-line-or-beginning-search
bindkey '^[[B' down-line-or-beginning-search
bindkey '^[OB' down-line-or-beginning-search

# Bind Home and End keys
bind_terminfo_key khome beginning-of-line   # [Home]
bind_terminfo_key kend end-of-line          # [End]

# Bind Shift-Tab for reverse menu completion
bind_terminfo_key kcbt reverse-menu-complete  # [Shift-Tab]

# Bind Backspace and Delete keys
bind_key_sequence '^?' backward-delete-char    # [Backspace]
if [[ -n "${terminfo[kdch1]}" ]]; then
  bind_terminfo_key kdch1 delete-char          # [Delete]
else
  bind_key_sequence '^[[3~' delete-char
fi

# Bind Ctrl-Delete and Ctrl-Backspace for word deletion
bind_key_sequence '^[[3;5~' kill-word          # [Ctrl-Delete]
bind_key_sequence '^H' backward-kill-word      # [Ctrl-Backspace]

# Bind Ctrl-Arrow keys for word navigation
bind_key_sequence '^[[1;5C' forward-word       # [Ctrl-RightArrow]
bind_key_sequence '^[[1;5D' backward-word      # [Ctrl-LeftArrow]

# Optional: Bind Left and Right arrows for word navigation
bindkey '^[[C' forward-word   # [RightArrow]
bindkey '^[[D' backward-word  # [LeftArrow]


# Additional keybindings
bindkey '\ew' kill-region                         # [Esc-w] - Kill to mark
bindkey -s '\el' 'ls\n'                           # [Esc-l] - Run 'ls'
bindkey '^r' history-incremental-search-backward  # [Ctrl-r] - Incremental search
bindkey ' ' magic-space                           # [Space] - Disable history expansion

# Load custom widgets
source <(cat $(ls -1 $ZCONFDIR/widgets/**/*))
