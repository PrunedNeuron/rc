# ZSH History configuration

HISTFILE=$HOME/.local/share/zsh/.zhistory
SAVEHIST=$(( 100 * 1000 ))
HISTSIZE=$(( 1.2 * SAVEHIST )) # ZSH recommended value
