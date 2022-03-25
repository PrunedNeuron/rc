#!/usr/bin/env zsh

# Reusable functions

typeset -a entries
typeset -U fpath

# List of paths of functions
entries=($(find "$ZCONFDIR/functions" -path "$ZCONFDIR/functions/lib" -prune -o -type f))

# Add functions directory to fpath
fpath=($ZCONFDIR/functions "${fpath[@]}")
export FPATH
autoload ${entries#$ZCONFDIR/functions/}
