# ~/.zprofile — Login shell only. Sources ~/.profile for POSIX login env.
emulate sh -c '[ -f "$HOME/.profile" ] && source "$HOME/.profile"'