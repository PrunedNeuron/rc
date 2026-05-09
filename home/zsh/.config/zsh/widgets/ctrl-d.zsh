# $ZCONFDIR/widgets/ctrl-d.zsh — smart Ctrl+D with double-press exit guard.
#
# Buffer non-empty      → delete-char (standard behaviour)
# Buffer empty, 1st press → show hint, do not exit
# Buffer empty, 2nd press → exit (standard EOF)
#
# Counter resets on every new prompt via add-zle-hook-widget (zsh ≥ 5.4).

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

_ctrl_d_reset_on_line_init() { _ctrl_d_count=0 }

zle -N _smart_ctrl_d
add-zle-hook-widget zle-line-init _ctrl_d_reset_on_line_init
bindkey '^D' _smart_ctrl_d
