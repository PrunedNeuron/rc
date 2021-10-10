# Programs

# junegunn/fzf-bin
# zinit ice from"gh-r" as"program" wait lucid
# zinit light junegunn/fzf-bin

# fm finder
zinit ice --depth'1' atinit'source fm.zsh' atclone'./fm__compile' atpull'%atclone'
zinit light ddnexus/fm

# Bitwarden exporter (with support for attachments)
zinit ice from"gh-r" as"program" wait lucid has"bw" mv"portwarden* -> portwarden"
zinit light vwxyzjn/portwarden

# Yank
zinit ice as"program" wait lucid pick"yank" make
zinit light mptre/yank

# exiftool
zinit ice as"program" has"perl" pick"exiftool" wait lucid
zinit light exiftool/exiftool

# Dry (Docker manager)
zinit ice from"gh-r" as"program" wait lucid has"docker" mv"dry* -> dry"
zinit light moncho/dry

# ugit (undo last git command)
zinit ice as"program" wait"4" lucid has"git" pick"ugit"
zinit light Bhupesh-V/ugit

# git diff so fancy
zinit ice as"program" wait"4" lucid has"git" pick"bin/git-dsf"
zinit light zdharma/zsh-diff-so-fancy

# fzpac
zinit ice as"program" wait"3" lucid has"fzf" has"pacman" pick"fzpac"
zinit light sheepla/fzpac

# fzfx
zinit ice as"program" wait"3" lucid has"fzf" has"pacman" pick"fzfx"
zinit light danisztls/fzfx

# asciinema
zinit ice as"command" wait"4" lucid has"python" \
    atinit"export PYTHONPATH=$ZPFX/lib/python3.7/site-packages/" \
    atclone"PYTHONPATH=$ZPFX/lib/python3.7/site-packages/ \
    python3 setup.py --quiet install --prefix $ZPFX" \
    atpull'%atclone' test'0' \
    pick"$ZPFX/bin/asciinema"
zinit light asciinema/asciinema

# pyenv
zinit ice as"command" wait"4" lucid has"python" \
    atclone'PYENV_ROOT="$PWD" ./libexec/pyenv init - > zpyenv.zsh' \
    atinit'export PYENV_ROOT="$PWD"' atpull"%atclone" \
    pick'bin/pyenv' src"zpyenv.zsh" nocompile'!'
zinit light pyenv/pyenv
