# Programs

zinit ice wait"5" lucid \
    atload'export NVM_SYMLINK_CURRENT="true" NVM_DIR="$HOME/.nvm" NVM_LAZY_LOAD=true'
zinit light lukechilds/zsh-nvm # This loads nvm on the first use of node, npm, etc

# Bitwarden exporter (with support for attachments)
zinit ice from"gh-r" as"program" mv"portwarden* -> portwarden"
zinit light vwxyzjn/portwarden
