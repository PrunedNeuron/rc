# Programs

# junegunn/fzf-bin
# zinit ice from"gh-r" as"program" wait lucid
# zinit light junegunn/fzf-bin

# fm finder
zinit ice wait"5" lucid --depth'1' atinit'source fm.zsh' atclone'./fm__compile' atpull'%atclone'
zinit light ddnexus/fm

# Bitwarden exporter (with support for attachments)
zinit ice wait"5" lucid from"gh-r" as"program" has"bw" mv"portwarden* -> portwarden"
zinit light vwxyzjn/portwarden

# Yank
zinit ice wait"5" lucid as"program" pick"yank" make
zinit light mptre/yank

# exiftool
zinit ice wait"5" lucid as"program" has"perl" pick"exiftool"
zinit light exiftool/exiftool

# Dry (Docker manager)
zinit ice wait"5" lucid from"gh-r" as"program" has"docker" mv"dry* -> dry"
zinit light moncho/dry

# ugit (undo last git command)
zinit ice wait"5" lucid as"program" has"git" pick"ugit"
zinit light Bhupesh-V/ugit

# git diff so fancy
zinit ice wait"5" lucid as"program" has"git" pick"bin/git-dsf"
zinit light zdharma-continuum/zsh-diff-so-fancy

# fzpac
zinit ice wait"5" lucid as"program" has"fzf" has"pacman" pick"fzpac"
zinit light sheepla/fzpac

# fzfx
zinit ice wait"5" lucid as"program" has"fzf" has"pacman" pick"fzfx"
zinit light danisztls/fzfx

# asciinema
zinit ice wait"5" lucid as"command" has"python" \
    atinit"export PYTHONPATH=$ZPFX/lib/python3.7/site-packages/" \
    atclone"PYTHONPATH=$ZPFX/lib/python3.7/site-packages/ \
    python3 setup.py --quiet install --prefix $ZPFX" \
    atpull'%atclone' test'0' \
    pick"$ZPFX/bin/asciinema"
zinit light asciinema/asciinema

# pyenv
zinit ice wait"5" lucid as"command" has"python" \
    atclone'PYENV_ROOT="$PWD" ./libexec/pyenv init - > zpyenv.zsh' \
    atinit'export PYENV_ROOT="$PWD"' atpull"%atclone" \
    pick'bin/pyenv' src"zpyenv.zsh" nocompile'!'
zinit light pyenv/pyenv
