#!/usr/bin/env bash

# Runs stow assuming that pwd is the dotfiles directory.
main() {
    if [ "$#" -lt 1 ]; then
        echo "Not enough arguments. Pass at least one."
    else
        stow -d home -t "$HOME" -S "$@"
    fi
}

main "$@"
