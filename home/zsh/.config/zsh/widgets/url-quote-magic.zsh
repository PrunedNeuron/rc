# $ZCONFDIR/widgets/url-quote-magic — auto-quote special URL characters.
#
# Replaces the default self-insert with a URL-aware version.
# Typed or pasted URLs no longer need manual escaping of ?, &, =, %, #, etc.
# Works correctly with bracketed-paste-magic (set up in keybindings.zsh).

autoload -Uz url-quote-magic
zle -N self-insert url-quote-magic
