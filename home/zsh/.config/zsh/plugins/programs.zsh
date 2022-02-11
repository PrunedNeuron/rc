# Programs

# junegunn/fzf-bin
# zinit ice from"gh-r" as"program" wait lucid
# zinit light junegunn/fzf-bin

# fm finder
# zinit ice wait"5" lucid --depth'1' atinit'source fm.zsh' atclone'./fm__compile' atpull'%atclone'
# zinit light ddnexus/fm

# Bitwarden exporter (with support for attachments)
# zinit ice wait"5" lucid from"gh-r" as"program" has"bw" mv"portwarden* -> portwarden"
# zinit light vwxyzjn/portwarden

# git diff so fancy
zinit ice wait"5" lucid as"program" has"git" pick"bin/git-dsf"
zinit light zdharma-continuum/zsh-diff-so-fancy

# fzpac
zinit ice wait"5" lucid as"program" has"fzf" has"pacman" pick"fzpac"
zinit light sheepla/fzpac
