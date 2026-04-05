# $ZCONFDIR/functions.zsh

typeset -gU fpath

# Add functions root and lib subdir (lib is fpath-only; not explicitly autoloaded
# — its helpers are lazy-loaded on first call by functions that depend on them).
fpath=($ZCONFDIR/functions.d $ZCONFDIR/functions.d/lib(N/) $fpath)
export FPATH

# Autoload all regular files under functions.d, excluding lib contents.
local -a _funcs=()
for _f in $ZCONFDIR/functions.d/**/*(N.); do
  [[ $_f != $ZCONFDIR/functions.d/lib/* ]] \
    && _funcs+=("${_f#$ZCONFDIR/functions.d/}")
done
(( ${#_funcs} )) && autoload -Uz $_funcs
unset _f _funcs
