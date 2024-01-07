# Programs

zi wait"1" lucid from"gh-r" as"null" for \
    sbin'**/zoxide' \
        atclone"./zoxide init --cmd j zsh > init.zsh" atpull"%atclone" src"init.zsh" nocompile'!' ajeetdsouza/zoxide \
    sbin'**/bat' \
        mv"**/autocomplete/bat.zsh -> $ZINIT[COMPLETIONS_DIR]/_bat" @sharkdp/bat \
    sbin'**/fd' \
        @sharkdp/fd
#     sbin'**/delta' \
#         atload"alias diff='delta -ns'" dandavison/delta \
#     sbin'**/vivid' \
#         atload'export LS_COLORS="$(vivid generate one-light)"' @sharkdp/vivid \
#     sbin'exa* -> exa' \
#         ogham/exa
