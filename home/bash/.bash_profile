# ~/.bash_profile

[ -f "$HOME/.envrc" ] && source "$HOME/.envrc"
[ -f "$HOME/.profile" ] && source "$HOME/.profile"

export PATH=$(IFS=$':'; echo "${paths[*]}")

[ -f ~/.bashrc ] && source ~/.bashrc
