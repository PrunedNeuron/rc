# widgets/ctrl-d.zsh — Smart Ctrl+D.
# Buffer non-empty   → delete-char (standard behaviour)
# Buffer empty, 1st  → show hint, do not exit
# Buffer empty, 2nd  → exit (standard EOF)
# Counter resets on every new prompt via add-zle-hook-widget.

typeset -gi _ctrl_d_count=0

_smart_ctrl_d() {
  if (( $#BUFFER > 0 )); then
    _ctrl_d_count=0
    zle delete-char
    return
  fi
  if (( ++_ctrl_d_count < 2 )); then
    zle -M 'Press Ctrl+D again to exit.'
    return
  fi
  exit 0
}

_ctrl_d_reset() { _ctrl_d_count=0 }

zle -N _smart_ctrl_d
add-zle-hook-widget zle-line-init _ctrl_d_reset
bindkey '^D' _smart_ctrl_d