# functions.zsh — fpath setup and autoload of custom functions.

typeset -gU fpath

# Add the functions root and its lib/ subdirectory to fpath.
# lib/ contains private helpers; they are autoloaded on-demand by the public
# functions that call them (autoload -Uz __helper_name inside those functions).
fpath=(
  "$ZCONFDIR/functions.d"
  "$ZCONFDIR/functions.d/lib"(N/)
  $fpath
)
export FPATH

# Autoload all regular files under functions.d/, excluding lib/ internals.
# NOTE: functions with the same name as definitions in widgets/pacman.zsh
# (pai, par, pao, pls, pup, pfi, pcc) will be shadowed by the widget file's
# eager definitions, which are canonical.
local -a _funcs=()
local _f
for _f in "$ZCONFDIR/functions.d"/**/*(N.); do
  [[ $_f == "$ZCONFDIR/functions.d/lib/"* ]] && continue
  _funcs+=("${_f#$ZCONFDIR/functions.d/}")
done
(( ${#_funcs} )) && autoload -Uz $_funcs
unset _f _funcs