# Reusable functions

typeset -a entries
typeset -U fpath

# List of paths of functions
entries=($(find "$ZCONFDIR/functions.d" -path "$ZCONFDIR/functions.d/lib" -prune -o -type f))

# Add functions directory to fpath
fpath=($ZCONFDIR/functions.d "${fpath[@]}")
export FPATH
autoload ${entries#$ZCONFDIR/functions.d/}

