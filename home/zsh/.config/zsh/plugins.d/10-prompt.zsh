# Prompt config

zi ice as'command' from'gh-r' \
        atload'export STARSHIP_CONFIG=$ZCONFDIR/themes/starship.toml; eval $(starship init zsh)' \
        atclone'./starship init zsh > init.zsh; ./starship completions zsh > _starship' \
        atpull'%atclone' src'init.zsh'
zi light starship/starship
