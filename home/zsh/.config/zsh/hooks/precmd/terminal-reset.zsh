# hooks/precmd/terminal-reset.zsh — Restore terminal state after a crashed
# program leaves it in raw/app mode (garbled display, no echo, etc.).
# Source: https://wiki.archlinux.org/title/Zsh#Restore_terminal_settings

_reset_broken_terminal_precmd() {
  printf '%b' '\e[0m\e(B\e)0\017\e[?5l\e7\e[0;0r\e8'
}

precmd_functions+=(_reset_broken_terminal_precmd)