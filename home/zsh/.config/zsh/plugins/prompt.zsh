# Prompt config

# Spaceship
#source $ZCONFDIR/themes/spaceship.zsh

# Pure
#source $ZCONFDIR/themes/pure.zsh

# Spaceship theme
#zinit light denysdovhan/spaceship-prompt

# Pure theme
#zinit ice compile'(pure|async).zsh' pick'async.zsh' src'pure.zsh'
#zinit light sindresorhus/pure

# Starship theme
# zinit ice from'gh-r' as'program' mv'target/*/release/starship -> starship' \
#         atload'export STARSHIP_CONFIG=$ZCONFDIR/themes/starship.toml; eval $(starship init zsh)'
# zinit light starship/starship

zinit ice as'command' from'gh-r' \
        atload'export STARSHIP_CONFIG=$ZCONFDIR/themes/starship.toml; eval $(starship init zsh)' \
        atclone'./starship init zsh > init.zsh; ./starship completions zsh > _starship' \
        atpull'%atclone' src'init.zsh'
zinit light starship/starship
