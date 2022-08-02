# Programs

## Programs
# vivid - sets LS_COLORS theme
# zi ice from'gh-r' as'program' mv'vivid* vivid' sbin'**/vivid(.exe|) -> vivid' \
#     atload'export LS_COLORS='$(vivid generate ayu)''
# zi light @sharkdp/vivid

# From gh:Jackson-soft/dotfiles/zsh/zshrc.zsh
# Modern Unix commands
# See gh:ibraheemdev/modern-unix

# zi wait"1a" lucid from"gh-r" as"null" for \
#     sbin"**/fd"         @sharkdp/fd \
#     sbin"**/bat"        @sharkdp/bat \
#     sbin"pacaptr"       rami3l/pacaptr \
#     sbin"**/delta"      dandavison/delta \
#     sbin"fzf" bpick"*linux*.tar.gz" \
#                         junegunn/fzf \
#     sbin"navi" atload'eval "$(navi widget zsh)"' \
#                         denisidoro/navi \
#     sbin"**/zoxide" atload'eval "$(zoxide init zsh)"' \
#                         ajeetdsouza/zoxide \
#     sbin"**/vivid" atload'export LS_COLORS="$(vivid generate one-light)"' \
#                         @sharkdp/vivid

zi wait"1" lucid from"gh-r" as"null" for \
    sbin'**/zoxide' \
        atclone"./zoxide init --cmd j zsh > init.zsh" atpull"%atclone" src"init.zsh" nocompile'!' ajeetdsouza/zoxide \
    sbin'**/bat' \
        mv"**/autocomplete/bat.zsh -> $ZINIT[COMPLETIONS_DIR]/_bat" @sharkdp/bat \
    sbin'**/exa' \
        mv"**/exa.zsh -> $ZINIT[COMPLETIONS_DIR]/_exa" sbin"**/exa" ogham/exa \
    sbin'**/vivid' \
        atload'export LS_COLORS="$(vivid generate one-light)"' @sharkdp/vivid \
    sbin'**/navi' \
        atload'eval "$(navi widget zsh)"' denisidoro/navi \
    sbin'**/delta' \
        atload"alias diff='delta -ns'" dandavison/delta \
    sbin'**/fd' \
        @sharkdp/fd
