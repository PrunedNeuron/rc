#!/usr/bin/env zsh

# Reusable functions

typeset -a entries
typeset -U fpath

entries=( $ZCONFDIR/functions/**/* ) # List of paths of functions

# Add functions directory to fpath
fpath=( $ZCONFDIR/functions "${fpath[@]}" )
export FPATH
autoload ${entries#$ZCONFDIR/functions/}
