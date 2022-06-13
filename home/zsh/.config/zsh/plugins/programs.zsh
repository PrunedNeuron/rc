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

## Programs
# vivid - sets LS_COLORS theme
# zinit ice from'gh-r' as'program' mv'vivid* vivid' sbin'**/vivid(.exe|) -> vivid' \
#     atload'export LS_COLORS="$(vivid generate ayu)"'
# zinit light @sharkdp/vivid

# revolver
zinit ice wait"2" lucid as"program" pick"revolver"
zinit light molovo/revolver

# irs music downloader with metadata
zinit ice from"gh-r" as"program"
zinit light cooperhammond/irs

