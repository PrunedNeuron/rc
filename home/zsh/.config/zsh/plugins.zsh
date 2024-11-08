# $ZCONFDIR/plugins.zsh
# zsh plugins, managed with zinit

# source <(cat $(ls -1 $ZCONFDIR/plugins.d/*.zsh))

# Prompt
command -v starship >/dev/null 2>&1 || curl -sS https://starship.rs/install.sh | sh -s -- --yes --bin-dir "$HOME/.local/bin"
export STARSHIP_CONFIG=$ZCONFDIR/themes/starship.toml; eval "$(starship init zsh)"

zcomet load le0me55i/zsh-systemd # systemd aliases

zcomet trigger send robertzk/send.zsh # add+commit+push

zcomet load zsh-users/zsh-completions
zcomet load zsh-users/zsh-syntax-highlighting
zcomet load zsh-users/zsh-autosuggestions

# Run compinit and compile its cache
zcomet compinit
