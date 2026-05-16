# ~/.zshenv — Sourced for every shell (login, interactive, scripts).
# RULE: No output, no aliases, no interactive features. Pure exports only.

# ── XDG ──────────────────────────────────────────────────────────────────────
export XDG_CONFIG_HOME="${XDG_CONFIG_HOME:-$HOME/.config}"
export XDG_CACHE_HOME="${XDG_CACHE_HOME:-$HOME/.cache}"
export XDG_DATA_HOME="${XDG_DATA_HOME:-$HOME/.local/share}"
export XDG_STATE_HOME="${XDG_STATE_HOME:-$HOME/.local/state}"

# ── Zsh layout ────────────────────────────────────────────────────────────────
export ZDOTDIR="$HOME"
export ZCONFDIR="$XDG_CONFIG_HOME/zsh"
export ZCACHEDIR="$XDG_CACHE_HOME/zsh"
export ZDATADIR="$XDG_DATA_HOME/zsh"

# ── Locale ────────────────────────────────────────────────────────────────────
export LANG="en_US.UTF-8"
export LC_ALL="en_US.UTF-8"

# ── Machine-local overrides (not in VCS) ─────────────────────────────────────
[[ -f "$HOME/.envrc" ]] && source "$HOME/.envrc"

# ── PATH deduplication ────────────────────────────────────────────────────────
typeset -gU PATH path
export PATH