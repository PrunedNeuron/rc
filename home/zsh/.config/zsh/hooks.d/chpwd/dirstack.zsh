# Dirstack chpwd hook | source: https://wiki.archlinux.org/title/Zsh

DIRSTACKDIR="${XDG_CACHE_HOME:-$HOME/.cache}/zsh" && mkdir -p "$DIRSTACKDIR"
DIRSTACKFILE="$DIRSTACKDIR/dirs"

if [[ -f "$DIRSTACKFILE" ]] && (( ${#dirstack} == 0 )); then
	dirstack=("${(@f)"$(< "$DIRSTACKFILE")"}")
	[[ -d "${dirstack[1]}" ]] && cd -- "${dirstack[1]}"
fi

dirstack_chpwd() {
	print -l -- "$PWD" "${(u)dirstack[@]}" > "$DIRSTACKFILE"
}

chpwd_functions+=(dirstack_chpwd)

# Use
DIRSTACKSIZE='20'

setopt AUTO_PUSHD PUSHD_SILENT PUSHD_TO_HOME

## Remove duplicate entries
setopt PUSHD_IGNORE_DUPS

## This reverts the +/- operators.
setopt PUSHD_MINUS
