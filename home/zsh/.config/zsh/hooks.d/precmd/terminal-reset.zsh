# ~/.config/zsh/hooks.d/precmd/terminal-reset.zsh
# Restore terminal state after a crashed program leaves it garbled.
# Source: https://wiki.archlinux.org/title/Zsh#Restore_terminal_settings

reset_broken_terminal_precmd() {
  printf '%b' '\e[0m\e(B\e)0\017\e[?5l\e7\e[0;0r\e8'
}

precmd_functions+=(reset_broken_terminal_precmd)
