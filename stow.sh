#!/usr/bin/env bash


main() {
    if [ "$#" -lt 1 ]; then
        echo "Not enough arguments. Pass at least one."
    else
        stow -d home -t "$HOME" -S "$@"
    fi
}

main "$@"
