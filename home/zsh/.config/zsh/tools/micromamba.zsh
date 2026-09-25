# tools/micromamba.zsh — Micromamba shell integration.
#
# Kept outside ~/.zshrc so the main startup manifest remains clean.

# >>> mamba initialize >>>
# !! Contents within this block are managed by 'micromamba shell init' !!

export MAMBA_EXE='/usr/bin/micromamba'
export MAMBA_ROOT_PREFIX="$HOME/.local/share/micromamba"

__mamba_setup="$(
  "$MAMBA_EXE" shell hook \
    --shell zsh \
    --root-prefix "$MAMBA_ROOT_PREFIX" \
    2>/dev/null
)"

if (( $? == 0 )); then
  eval "$__mamba_setup"
else
  alias micromamba="$MAMBA_EXE"
fi

unset __mamba_setup

# <<< mamba initialize <<<
