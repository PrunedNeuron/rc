# $ZCONFDIR/widgets/url-quote-magic.zsh — auto-quote special URL characters.
#
# Replaces the default self-insert with a URL-aware version so that typed or
# pasted URLs do not need manual escaping of ?, &, =, %, #, etc.
# Works correctly with bracketed-paste-magic (configured in keybindings.zsh).

autoload -Uz url-quote-magic
zle -N self-insert url-quote-magic
