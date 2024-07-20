# ~/.zsh/plugins.zsh
# zsh plugins, managed with zinit

source <(cat $(ls -1 $ZCONFDIR/plugins.d/*.zsh))
#
# # source antidote
# # ${ZDOTDIR:-~}/.zshrc
#
# # Set the root name of the plugins files (.txt and .zsh) antidote will use.
# zsh_plugins=${ZDOTDIR:-~}/.zsh_plugins
# antidote_path=${ZDATADIR}/.antidote
#
# # Ensure the .zsh_plugins.txt file exists so you can add plugins.
# [[ -f ${ZCONFDIR}/plugins.txt ]] || touch ${ZCONFDIR}/plugins.txt
#
# # Lazy-load antidote from its functions directory.
# fpath=(${ZDATADIR}/.antidote/functions $fpath)
# autoload -Uz antidote
#
# # Generate a new static file whenever .zsh_plugins.txt is updated.
# if [[ ! ${ZDATADIR}/antidote_plugins.zsh -nt ${ZCONFDIR}/plugins.txt ]]; then
#   antidote bundle <${ZCONFDIR}/plugins.txt >${ZDATADIR}/antidote_plugins.zsh
# fi
#
# # Source your static plugins file.
# source ${ZDATADIR}/antidote_plugins.zsh

