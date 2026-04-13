# $ZCONFDIR/functions.zsh — autoload custom functions from functions.d/

typeset -gU fpath

# Add functions root and lib subdir (lib is fpath-only; helpers lazy-loaded
# on first call by functions that depend on them).
fpath=("$ZCONFDIR/functions.d" "$ZCONFDIR/functions.d/lib"(N/) $fpath)
export FPATH

# Autoload all regular files under functions.d/, excluding lib/ internals.
local -a _funcs=()
local _f
for _f in "$ZCONFDIR/functions.d"/**/*(N.); do
  [[ $_f != "$ZCONFDIR/functions.d/lib/"* ]] \
    && _funcs+=("${_f#$ZCONFDIR/functions.d/}")
done
(( ${#_funcs} )) && autoload -Uz $_funcs
unset _f _funcs
