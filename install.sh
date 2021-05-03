#!/bin/bash

shopt -s nullglob

function usage() {
    echo "Usage: $0 -d dir"
    echo -e "\t-d stow directory"
    exit 1
}

function dirnames() {
    names=()
    for d in "$@"; do
        names+=( "$(pkg $d)" )
    done
    echo "${names[@]}"
}

function pkg() {
    path="${1%/}"
    printf "${path##*/}"
}

function main() {
    for directory in "$@"; do
        for file in $directory/*/; do
            echo "Stowing $directory -> $(pkg $file)..."
            stow --no --target "$HOME" --dir "$directory" --stow "$(pkg $file)"
        done
    done
}


declare -A stow_dirs
# Begin execution

while getopts :d: opt; do
    case "$opt" in
        d ) stow_dirs="$OPTARG" ;;
        ? ) usage ;;
    esac
done

if [ ${#stow_dirs[@]} -eq 0 ]; then
    stow_dirs=`dirnames */`
    main ${stow_dirs[@]}
else
    main ${stow_dirs[@]}
fi

shopt -u nullglob
