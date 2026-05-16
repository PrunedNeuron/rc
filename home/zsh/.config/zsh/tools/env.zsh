# tools/env.zsh — Static tool exports and the _cached_eval helper.
# Sourced BEFORE zimfw/post.zsh so variables are visible at plugin load time.

# ── Startup init cache ────────────────────────────────────────────────────────
# Caches stdout of a tool's init command; invalidates when the binary mtime
# is newer than the cache. Atomic write (tmp + rename) prevents partial reads
# on concurrent shell starts.
_cached_eval() {
  local _bin _cache
  local -A _st_bin _st_cache

  _bin=$(whence -p "$1" 2>/dev/null) || {
    print -u2 "zsh: _cached_eval: '$1' not found, skipping"
    return 1
  }

  mkdir -p "$ZCACHEDIR"
  _cache="$ZCACHEDIR/eval_${1:t}.zsh"

  zstat -H _st_bin "$_bin" 2>/dev/null || return 1
  local _bin_mtime=$_st_bin[mtime]

  local _cache_mtime=0
  if [[ -s $_cache ]]; then
    zstat -H _st_cache "$_cache" 2>/dev/null && _cache_mtime=$_st_cache[mtime]
  fi

  if (( _cache_mtime < _bin_mtime )); then
    local _tmp="${_cache}.tmp.$$"
    if "$@" >| "$_tmp" 2>/dev/null; then
      mv -f "$_tmp" "$_cache"
    else
      rm -f "$_tmp"; return 1
    fi
  fi

  builtin source "$_cache"
}

# ── bat ───────────────────────────────────────────────────────────────────────
export BAT_THEME='Catppuccin Mocha'

# ── eza ───────────────────────────────────────────────────────────────────────
export EZA_COLORS="da=36"
export EZA_ICONS_AUTO=1

# ── vivid → LS_COLORS ────────────────────────────────────────────────────────
if command -v vivid &>/dev/null; then
  export LS_COLORS="$(vivid generate catppuccin-mocha 2>/dev/null \
                      || vivid generate snazzy 2>/dev/null)"
else
  command -v dircolors &>/dev/null \
    && eval "$(dircolors -b ~/.dircolors 2>/dev/null || dircolors -b)"
fi

# ── zsh-you-should-use ────────────────────────────────────────────────────────
export YSU_MESSAGE_POSITION="after"
export YSU_MODE=ALL
export YSU_IGNORED_ALIASES=('g' 'l' 's' 'll' 'la')

# ── forgit ────────────────────────────────────────────────────────────────────
export FORGIT_LOG_FORMAT='%C(auto)%h%C(reset) %C(blue)%an%C(reset) %C(green)(%ar)%C(reset)%C(auto)%d%C(reset) %s'
export FORGIT_COPY_CMD='wl-copy'
command -v delta &>/dev/null && export FORGIT_PAGER='delta'

# ── fzf-git.sh ────────────────────────────────────────────────────────────────
command -v delta &>/dev/null && export FZF_GIT_PAGER='delta'

# ── zsh-abbr ─────────────────────────────────────────────────────────────────
export ABBR_SET_EXPANSION_CURSOR=1
export ABBR_EXPAND_PUSH_ABBREVIATION_TO_HISTORY=1

# ── carapace ─────────────────────────────────────────────────────────────────
# CARAPACE_BRIDGES priority: zsh-native completions > fish bridge > bash bridge.
# Native zsh completions (zsh-users/zsh-completions, any compdef'd function)
# take precedence; carapace fills everything else.
# CARAPACE_ENV: include environment variable name completions.
export CARAPACE_BRIDGES='zsh,fish,bash'
export CARAPACE_ENV=1