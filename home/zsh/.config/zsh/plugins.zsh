# ~/.zsh/plugins.zsh
# zsh plugins, managed with zinit

source <(cat $(ls -1 $ZCONFDIR/plugins.d/*.zsh))
# source ${ZDATADIR}/.antidote/antidote.zsh
#
# antidote bundle <${ZCONFDIR}/plugins.txt >${ZDATADIR}/antidote_plugins.zsh
#
# source ${ZDATADIR}/antidote_plugins.zsh
