# $ZCONFDIR/other/pre.zsh

if [[ ! -f ${ZDOTDIR:-${HOME}}/.zcomet/bin/zcomet.zsh ]]; then
  command git clone https://github.com/agkozak/zcomet.git ${ZDOTDIR:-${HOME}}/.zcomet/bin
fi

source ${ZDOTDIR:-${HOME}}/.zcomet/bin/zcomet.zsh

# Add precmd and chpwd hooks
# source $ZCONFDIR/hooks.zsh

# Add zsh mods
# source $ZCONFDIR/zmods.zsh
