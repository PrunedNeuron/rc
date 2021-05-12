# Programs

zinit ice wait"5" has"node" lucid \
    atload'export NVM_SYMLINK_CURRENT="true" NVM_DIR="$HOME/.nvm" NVM_LAZY_LOAD=true'
zinit light lukechilds/zsh-nvm # This loads nvm on the first use of node, npm, etc

# Bitwarden exporter (with support for attachments)
zinit ice from"gh-r" as"program" has"bw" mv"portwarden* -> portwarden"
zinit light vwxyzjn/portwarden

# Yank
zinit ice as"program" pick"yank" make
zinit light mptre/yank

# exiftool
zinit ice as"program" has"perl" pick"exiftool"
zinit light exiftool/exiftool

# Dry (Docker manager)
zinit ice from"gh-r" as"program" has"docker" mv"dry* -> dry"
zinit light moncho/dry

# ugit (undo last git command)
zinit ice as"program" pick"ugit"
zinit light Bhupesh-V/ugit

# git diff so fancy
zplugin ice as"program" pick"bin/git-dsf"
zplugin light zdharma/zsh-diff-so-fancy

# asciinema
zinit ice as"command" has"python" wait lucid \
    atinit"export PYTHONPATH=$ZPFX/lib/python3.7/site-packages/" \
    atclone"PYTHONPATH=$ZPFX/lib/python3.7/site-packages/ \
    python3 setup.py --quiet install --prefix $ZPFX" \
    atpull'%atclone' test'0' \
    pick"$ZPFX/bin/asciinema"
zinit light asciinema/asciinema
