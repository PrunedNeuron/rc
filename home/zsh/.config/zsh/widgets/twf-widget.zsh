#!/usr/bin/env zsh
# $ZCONFDIR/widgets/twf-widget — DELETE or disable entirely.

# twf-widget conflicts with fzf's Ctrl+T and is strictly worse.
# If you want twf accessible, rebind it to something unused, e.g. Alt+T:
twf-widget() {
  local selected
  selected=$(twf --height=0.5) || { zle reset-prompt; return 1 }
  BUFFER="$BUFFER$selected"
  zle end-of-line
  zle reset-prompt
}
zle -N twf-widget
bindkey -M emacs '^[t' twf-widget   # Alt+T — no conflict
bindkey -M viins '^[t' twf-widget
