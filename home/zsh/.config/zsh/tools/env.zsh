# tools/env.zsh — Static exports, plugin configuration and cached init helper.
# Sourced BEFORE Zim initialises plugins so plugin startup sees final settings.

# ══════════════════════════════════════════════════════════════════════════════
# Cached tool initialisation
# ══════════════════════════════════════════════════════════════════════════════
# Cache key includes the command arguments and Zsh version, preventing different
# init modes for the same binary from accidentally sharing one generated script.
# Binary mtime invalidates the cache after upgrades. Writes are atomic.
_cached_eval() {
  local _bin _cache _tmp _key
  local -A _st_bin _st_cache

  _bin=$(whence -p "$1" 2>/dev/null) || return 127

  mkdir -p "$ZCACHEDIR" || return 1

  _key="${ZSH_VERSION}_${(j:_:)@}"
  _key=${_key//[^[:alnum:]_.-]/_}
  _cache="$ZCACHEDIR/eval_${_key}.zsh"

  zstat -H _st_bin "$_bin" 2>/dev/null || return 1
  local _bin_mtime=${_st_bin[mtime]}
  local _cache_mtime=0

  if [[ -s $_cache ]]; then
    zstat -H _st_cache "$_cache" 2>/dev/null \
      && _cache_mtime=${_st_cache[mtime]}
  fi

  if (( _cache_mtime < _bin_mtime )); then
    _tmp="${_cache}.tmp.$$.$RANDOM"
    if "$@" >| "$_tmp" 2>/dev/null; then
      mv -f -- "$_tmp" "$_cache"
    else
      rm -f -- "$_tmp"
      return 1
    fi
  fi

  builtin source "$_cache"
}

# ══════════════════════════════════════════════════════════════════════════════
# Tool environment
# ══════════════════════════════════════════════════════════════════════════════
export BAT_THEME='Catppuccin Mocha'
export EZA_COLORS='da=36'
export EZA_ICONS_AUTO=1

# vivid -> LS_COLORS. This runs before completion.zsh, so compsys/fzf-tab receive
# the final colour map immediately; no sched workaround is necessary.
if command -v vivid &>/dev/null; then
  export LS_COLORS="$(vivid generate catppuccin-mocha 2>/dev/null \
                      || vivid generate snazzy 2>/dev/null)"
elif command -v dircolors &>/dev/null; then
  eval "$(dircolors -b ~/.dircolors 2>/dev/null || dircolors -b)"
fi

# zsh-you-should-use
export YSU_MESSAGE_POSITION='after'
export YSU_MODE=ALL
YSU_IGNORED_ALIASES=('g' 'l' 's' 'll' 'la')

# forgit / fzf-git.sh
export FORGIT_LOG_FORMAT='%C(auto)%h%C(reset) %C(blue)%an%C(reset) %C(green)(%ar)%C(reset)%C(auto)%d%C(reset) %s'
export FORGIT_COPY_CMD='wl-copy'
command -v delta &>/dev/null && export FORGIT_PAGER='delta'
command -v delta &>/dev/null && export FZF_GIT_PAGER='delta'

# zsh-abbr
export ABBR_SET_EXPANSION_CURSOR=1
export ABBR_EXPAND_PUSH_ABBREVIATION_TO_HISTORY=1

# carapace
export CARAPACE_BRIDGES='zsh,fish,bash'
export CARAPACE_ENV=1

# ══════════════════════════════════════════════════════════════════════════════
# Plugin configuration — MUST precede plugin load
# ══════════════════════════════════════════════════════════════════════════════
# zsh-autosuggestions
ZSH_AUTOSUGGEST_STRATEGY=(abbreviations history completion)
ZSH_AUTOSUGGEST_BUFFER_MAX_SIZE=20
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=#585b70,italic'
# Modern zsh-autosuggestions is asynchronous by default on supported Zsh, but
# set this explicitly to document and preserve the intended behaviour.
ZSH_AUTOSUGGEST_USE_ASYNC=1
# All custom widgets exist before the first precmd, so one bind pass is enough.
ZSH_AUTOSUGGEST_MANUAL_REBIND=1

# zsh-history-substring-search
HISTORY_SUBSTRING_SEARCH_FUZZY=1
HISTORY_SUBSTRING_SEARCH_ENSURE_UNIQUE=1
HISTORY_SUBSTRING_SEARCH_HIGHLIGHT_FOUND='bg=#313244,fg=#cba6f7,bold'
HISTORY_SUBSTRING_SEARCH_HIGHLIGHT_NOT_FOUND='bg=#313244,fg=#f38ba8,bold'

# zsh-syntax-highlighting
ZSH_HIGHLIGHT_HIGHLIGHTERS=(main brackets pattern)
typeset -gA ZSH_HIGHLIGHT_STYLES

ZSH_HIGHLIGHT_STYLES[unknown-token]='fg=#f38ba8,bold'
ZSH_HIGHLIGHT_STYLES[reserved-word]='fg=#cba6f7,bold'
ZSH_HIGHLIGHT_STYLES[alias]='fg=#89dceb'
ZSH_HIGHLIGHT_STYLES[suffix-alias]='fg=#89dceb'
ZSH_HIGHLIGHT_STYLES[global-alias]='fg=#89dceb'
ZSH_HIGHLIGHT_STYLES[builtin]='fg=#89b4fa'
ZSH_HIGHLIGHT_STYLES[function]='fg=#89b4fa'
ZSH_HIGHLIGHT_STYLES[command]='fg=#a6e3a1'
ZSH_HIGHLIGHT_STYLES[precommand]='fg=#f9e2af,italic'
ZSH_HIGHLIGHT_STYLES[commandseparator]='fg=#cba6f7'
ZSH_HIGHLIGHT_STYLES[autodirectory]='fg=#fab387,underline'
ZSH_HIGHLIGHT_STYLES[arg0]='fg=#cdd6f4'

ZSH_HIGHLIGHT_STYLES[path]='fg=#cdd6f4,underline'
ZSH_HIGHLIGHT_STYLES[path_pathseparator]='fg=#f38ba8,underline'
ZSH_HIGHLIGHT_STYLES[path_prefix]='fg=#cdd6f4,underline'
ZSH_HIGHLIGHT_STYLES[path_prefix_pathseparator]='fg=#f38ba8,underline'
ZSH_HIGHLIGHT_STYLES[globbing]='fg=#fab387'
ZSH_HIGHLIGHT_STYLES[history-expansion]='fg=#cba6f7'
ZSH_HIGHLIGHT_STYLES[assign]='fg=#cdd6f4'

ZSH_HIGHLIGHT_STYLES[redirection]='fg=#f9e2af,bold'
ZSH_HIGHLIGHT_STYLES[named-fd]='fg=#f9e2af'
ZSH_HIGHLIGHT_STYLES[numeric-fd]='fg=#f9e2af'
ZSH_HIGHLIGHT_STYLES[process-substitution]='fg=#f5e0dc'
ZSH_HIGHLIGHT_STYLES[process-substitution-delimiter]='fg=#f5e0dc'

ZSH_HIGHLIGHT_STYLES[single-quoted-argument]='fg=#a6e3a1'
ZSH_HIGHLIGHT_STYLES[double-quoted-argument]='fg=#a6e3a1'
ZSH_HIGHLIGHT_STYLES[dollar-quoted-argument]='fg=#a6e3a1'
ZSH_HIGHLIGHT_STYLES[rc-quote]='fg=#a6e3a1'
ZSH_HIGHLIGHT_STYLES[dollar-double-quoted-argument]='fg=#cba6f7'
ZSH_HIGHLIGHT_STYLES[back-double-quoted-argument]='fg=#cba6f7'
ZSH_HIGHLIGHT_STYLES[back-dollar-quoted-argument]='fg=#cba6f7'

ZSH_HIGHLIGHT_STYLES[command-substitution]='fg=#f5e0dc'
ZSH_HIGHLIGHT_STYLES[command-substitution-quoted]='fg=#f5e0dc'
ZSH_HIGHLIGHT_STYLES[command-substitution-delimiter]='fg=#f5e0dc,bold'
ZSH_HIGHLIGHT_STYLES[command-substitution-delimiter-quoted]='fg=#f5e0dc,bold'

ZSH_HIGHLIGHT_STYLES[comment]='fg=#585b70,italic'
ZSH_HIGHLIGHT_STYLES[bracket-error]='fg=#f38ba8,bold'
ZSH_HIGHLIGHT_STYLES[bracket-level-1]='fg=#cba6f7,bold'
ZSH_HIGHLIGHT_STYLES[bracket-level-2]='fg=#f9e2af,bold'
ZSH_HIGHLIGHT_STYLES[bracket-level-3]='fg=#a6e3a1,bold'
ZSH_HIGHLIGHT_STYLES[bracket-level-4]='fg=#89b4fa,bold'
ZSH_HIGHLIGHT_STYLES[bracket-level-5]='fg=#f38ba8,bold'
ZSH_HIGHLIGHT_STYLES[cursor-matchingbracket]='standout'
