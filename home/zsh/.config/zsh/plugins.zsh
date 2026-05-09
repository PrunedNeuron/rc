# $ZCONFDIR/plugins.zsh — external tool integration.
# Sourced after init/post.zsh, so ZIM_HOME/init.zsh (and all plugins) have
# already been loaded. Variables here configure plugins post-load.

# ══════════════════════════════════════════════════════════════════════════════
# Startup cache helper
# ══════════════════════════════════════════════════════════════════════════════
# Caches stdout of a tool's init command; invalidates automatically when the
# binary mtime is newer than the cache. Write-locks via temp-file-rename to
# prevent partial reads on concurrent shell starts.
_cached_eval() {
  local _bin _cache
  local -A _st_bin _st_cache

  _bin=$(whence -p "$1" 2>/dev/null) || {
    print -u2 "plugins.zsh: '$1' not found, skipping"
    return 1
  }

  _cache="$ZCACHEDIR/eval_${1:t}.zsh"

  zstat -H _st_bin "$_bin" 2>/dev/null || return 1

  local _bin_mtime=$_st_bin[mtime]
  local _cache_mtime=0
  [[ -s $_cache ]] && zstat -H _st_cache "$_cache" 2>/dev/null \
    && _cache_mtime=$_st_cache[mtime]

  if (( _cache_mtime < _bin_mtime )); then
    mkdir -p "${_cache:h}"
    local _tmp="${_cache}.tmp.$$"
    if "$@" >| "$_tmp" 2>/dev/null; then
      mv -f "$_tmp" "$_cache"
    else
      rm -f "$_tmp"; return 1
    fi
  fi

  builtin source "$_cache"
}

# ══════════════════════════════════════════════════════════════════════════════
# bat
# ══════════════════════════════════════════════════════════════════════════════
# Theme install: mkdir -p "$(bat --config-dir)/themes" && bat cache --build
export BAT_THEME='Catppuccin Mocha'

# ══════════════════════════════════════════════════════════════════════════════
# eza
# ══════════════════════════════════════════════════════════════════════════════
export EZA_COLORS="da=36"   # dates in cyan; everything else from LS_COLORS
export EZA_ICONS_AUTO=1     # always show icons without passing --icons

# ══════════════════════════════════════════════════════════════════════════════
# zsh-autosuggestions
# ══════════════════════════════════════════════════════════════════════════════
# ZSH_AUTOSUGGEST_MANUAL_REBIND=1 is set in init/post.zsh, before
# ZIM_HOME/init.zsh sources the plugin. That is the ONLY correct location —
# the plugin checks this variable at source time.
#
# Belt-and-suspenders: if this shell was started via `exec zsh` mid-session
# (or any path where init/post.zsh's variable was not visible to the plugin
# at load time), remove the precmd hook now. Idempotent — no-ops if the hook
# was never registered.
(( ${+functions[_zsh_autosuggest_start]} )) \
  && add-zsh-hook -d precmd _zsh_autosuggest_start 2>/dev/null

# Strategy: abbreviations-aware first (registered by the abbreviations-strategy
# module), then history, then completion engine as final fallback.
ZSH_AUTOSUGGEST_STRATEGY=(abbreviations history completion)
ZSH_AUTOSUGGEST_BUFFER_MAX_SIZE=20
ZSH_AUTOSUGGEST_USE_ASYNC=1
# Catppuccin Mocha surface2 — visible but clearly subordinate to real text
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=#585b70,italic'

# ══════════════════════════════════════════════════════════════════════════════
# zsh-syntax-highlighting — Catppuccin Mocha colour scheme
# ══════════════════════════════════════════════════════════════════════════════
# Highlighters: main (command syntax), brackets (matching pairs), pattern (custom).
# 'cursor' and 'root' omitted — cursor colouring conflicts with terminal themes;
# 'root' is redundant with starship's root indicator.
ZSH_HIGHLIGHT_HIGHLIGHTERS=(main brackets pattern)

typeset -A ZSH_HIGHLIGHT_STYLES

# ── Commands ──────────────────────────────────────────────────────────────────
ZSH_HIGHLIGHT_STYLES[unknown-token]='fg=#f38ba8,bold'           # red — typo/not found
ZSH_HIGHLIGHT_STYLES[reserved-word]='fg=#cba6f7,bold'           # mauve — if/for/while
ZSH_HIGHLIGHT_STYLES[alias]='fg=#89dceb'                        # sky — alias names
ZSH_HIGHLIGHT_STYLES[suffix-alias]='fg=#89dceb'
ZSH_HIGHLIGHT_STYLES[global-alias]='fg=#89dceb'
ZSH_HIGHLIGHT_STYLES[builtin]='fg=#89b4fa'                      # blue — echo/cd/etc.
ZSH_HIGHLIGHT_STYLES[function]='fg=#89b4fa'                     # blue — defined functions
ZSH_HIGHLIGHT_STYLES[command]='fg=#a6e3a1'                      # green — external commands
ZSH_HIGHLIGHT_STYLES[precommand]='fg=#f9e2af,italic'            # yellow — sudo/env/time
ZSH_HIGHLIGHT_STYLES[commandseparator]='fg=#cba6f7'             # mauve — ; | &&
ZSH_HIGHLIGHT_STYLES[autodirectory]='fg=#fab387,underline'      # peach — bare cd target
ZSH_HIGHLIGHT_STYLES[arg0]='fg=#cdd6f4'                        # text — first arg

# ── Arguments and paths ───────────────────────────────────────────────────────
ZSH_HIGHLIGHT_STYLES[path]='fg=#cdd6f4,underline'
ZSH_HIGHLIGHT_STYLES[path_pathseparator]='fg=#f38ba8,underline' # red slashes in paths
ZSH_HIGHLIGHT_STYLES[path_prefix]='fg=#cdd6f4,underline'
ZSH_HIGHLIGHT_STYLES[path_prefix_pathseparator]='fg=#f38ba8,underline'
ZSH_HIGHLIGHT_STYLES[globbing]='fg=#fab387'                     # peach — * ? [...]
ZSH_HIGHLIGHT_STYLES[history-expansion]='fg=#cba6f7'            # mauve — !! !$
ZSH_HIGHLIGHT_STYLES[assign]='fg=#cdd6f4'                       # text — VAR=val

# ── Redirection and process substitution ──────────────────────────────────────
ZSH_HIGHLIGHT_STYLES[redirection]='fg=#f9e2af,bold'             # yellow — > >> <
ZSH_HIGHLIGHT_STYLES[named-fd]='fg=#f9e2af'
ZSH_HIGHLIGHT_STYLES[numeric-fd]='fg=#f9e2af'
ZSH_HIGHLIGHT_STYLES[process-substitution]='fg=#f5e0dc'         # rosewater
ZSH_HIGHLIGHT_STYLES[process-substitution-delimiter]='fg=#f5e0dc'

# ── Quoting ───────────────────────────────────────────────────────────────────
ZSH_HIGHLIGHT_STYLES[single-quoted-argument]='fg=#a6e3a1'       # green
ZSH_HIGHLIGHT_STYLES[double-quoted-argument]='fg=#a6e3a1'
ZSH_HIGHLIGHT_STYLES[dollar-quoted-argument]='fg=#a6e3a1'
ZSH_HIGHLIGHT_STYLES[rc-quote]='fg=#a6e3a1'
ZSH_HIGHLIGHT_STYLES[dollar-double-quoted-argument]='fg=#cba6f7' # mauve — $var in ""
ZSH_HIGHLIGHT_STYLES[back-double-quoted-argument]='fg=#cba6f7'   # mauve — \n in ""
ZSH_HIGHLIGHT_STYLES[back-dollar-quoted-argument]='fg=#cba6f7'

# ── Command substitution ──────────────────────────────────────────────────────
ZSH_HIGHLIGHT_STYLES[command-substitution]='fg=#f5e0dc'
ZSH_HIGHLIGHT_STYLES[command-substitution-quoted]='fg=#f5e0dc'
ZSH_HIGHLIGHT_STYLES[command-substitution-delimiter]='fg=#f5e0dc,bold'
ZSH_HIGHLIGHT_STYLES[command-substitution-delimiter-quoted]='fg=#f5e0dc,bold'

# ── Comments ──────────────────────────────────────────────────────────────────
ZSH_HIGHLIGHT_STYLES[comment]='fg=#585b70,italic'               # surface2 — dimmed

# ── Brackets (highlighter: brackets) ─────────────────────────────────────────
ZSH_HIGHLIGHT_STYLES[bracket-error]='fg=#f38ba8,bold'
ZSH_HIGHLIGHT_STYLES[bracket-level-1]='fg=#cba6f7,bold'
ZSH_HIGHLIGHT_STYLES[bracket-level-2]='fg=#f9e2af,bold'
ZSH_HIGHLIGHT_STYLES[bracket-level-3]='fg=#a6e3a1,bold'
ZSH_HIGHLIGHT_STYLES[bracket-level-4]='fg=#89b4fa,bold'
ZSH_HIGHLIGHT_STYLES[bracket-level-5]='fg=#f38ba8,bold'
ZSH_HIGHLIGHT_STYLES[cursor-matchingbracket]='standout'

# ══════════════════════════════════════════════════════════════════════════════
# zsh-history-substring-search
# ══════════════════════════════════════════════════════════════════════════════
HISTORY_SUBSTRING_SEARCH_FUZZY=1
HISTORY_SUBSTRING_SEARCH_ENSURE_UNIQUE=1
HISTORY_SUBSTRING_SEARCH_HIGHLIGHT_FOUND='bg=#313244,fg=#cba6f7,bold'
HISTORY_SUBSTRING_SEARCH_HIGHLIGHT_NOT_FOUND='bg=#313244,fg=#f38ba8,bold'

# ══════════════════════════════════════════════════════════════════════════════
# zsh-you-should-use
# ══════════════════════════════════════════════════════════════════════════════
export YSU_MESSAGE_POSITION="after"
export YSU_MODE=ALL
export YSU_IGNORED_ALIASES=('g' 'l' 's' 'll' 'la')

# ══════════════════════════════════════════════════════════════════════════════
# forgit — interactive git via fzf
# ══════════════════════════════════════════════════════════════════════════════
export FORGIT_LOG_FORMAT='%C(auto)%h%C(reset) %C(blue)%an%C(reset) %C(green)(%ar)%C(reset)%C(auto)%d%C(reset) %s'
export FORGIT_COPY_CMD='wl-copy'
command -v delta &>/dev/null && export FORGIT_PAGER='delta'

# ══════════════════════════════════════════════════════════════════════════════
# fzf-git.sh
# ══════════════════════════════════════════════════════════════════════════════
command -v delta &>/dev/null && export FZF_GIT_PAGER='delta'

# ══════════════════════════════════════════════════════════════════════════════
# zsh-abbr
# ══════════════════════════════════════════════════════════════════════════════
export ABBR_SET_EXPANSION_CURSOR=1
export ABBR_EXPAND_PUSH_ABBREVIATION_TO_HISTORY=1

# ══════════════════════════════════════════════════════════════════════════════
# FZF — Catppuccin Mocha palette
# ══════════════════════════════════════════════════════════════════════════════
_fzf_mocha=(
  '--color=bg+:#313244,bg:#1e1e2e,spinner:#f5e0dc,hl:#f38ba8'
  '--color=fg:#cdd6f4,header:#f38ba8,info:#cba6f7,pointer:#f5e0dc'
  '--color=marker:#b4befe,fg+:#cdd6f4,prompt:#cba6f7,hl+:#f38ba8'
  '--color=selected-bg:#45475a,border:#585b70,label:#cdd6f4'
  '--color=preview-bg:#1e1e2e,preview-border:#585b70,preview-label:#cdd6f4'
  '--color=gutter:#1e1e2e,query:#cdd6f4,disabled:#6c7086'
  '--color=input-border:#585b70,input-label:#cba6f7'
  '--color=list-border:#45475a,header-border:#585b70'
)

# ══════════════════════════════════════════════════════════════════════════════
# FZF — source commands
# ══════════════════════════════════════════════════════════════════════════════
export FZF_DEFAULT_COMMAND='fd --type f --hidden --follow --exclude .git'
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_ALT_C_COMMAND='fd --type d --hidden --follow --exclude .git'
export FZF_COMPLETION_DIR_COMMANDS='cd pushd rmdir tree eza ls'

# ══════════════════════════════════════════════════════════════════════════════
# FZF — global defaults (FZF_DEFAULT_OPTS)
# ══════════════════════════════════════════════════════════════════════════════
#
# HARD CONSTRAINTS:
#   (1) NO --bind=tab:accept  — breaks fzf-tab's continuous-trigger
#   (2) NO --multi            — breaks fzf-tab's Tab-to-accept workflow
#   (3) NO clipboard bindings — fire spuriously during fzf-tab completions
#   (4) --scheme is per-context, never global
#
# --tmux guarded: popup geometry is meaningless outside tmux; --height is
# the correct fallback for bare terminal use.
[[ -n $TMUX ]] && _fzf_tmux='--tmux center,85%' || _fzf_tmux=''

export FZF_DEFAULT_OPTS="
  --height=60%
  ${_fzf_tmux}
  --layout=reverse
  --style=full
  --border=rounded
  --padding=0,1
  --info=inline-right
  --prompt='❯ '
  --pointer='▶'
  --marker='✓'
  --separator='─'
  --scrollbar='│'
  --cycle
  --scroll-off=5
  --highlight-line
  --wrap-sign=$'\t↳ '
  ${_fzf_mocha[@]}
  --preview-window=right:55%:border-rounded:wrap
  --bind=ctrl-space:toggle+down
  --bind=ctrl-a:toggle-all
  --bind=ctrl-/:toggle-preview
  --bind='alt-up:preview-up'
  --bind='alt-down:preview-down'
  --bind='alt-f:preview-page-down'
  --bind='alt-b:preview-page-up'
  --bind='alt-e:preview-top'
  --bind='alt-E:preview-bottom'
  --bind='ctrl-s:toggle-sort'
"
unset _fzf_mocha _fzf_tmux

# ══════════════════════════════════════════════════════════════════════════════
# FZF — Ctrl+T: file picker
# ══════════════════════════════════════════════════════════════════════════════
export FZF_CTRL_T_OPTS="
  --multi
  --scheme=path
  --input-label=' Files '
  --walker-skip=.git,node_modules,.cache,.venv,__pycache__
  --header='  CTRL-E: edit  CTRL-Y: copy  CTRL-/: preview  CTRL-A: all'
  --header-border=bottom
  --preview='
    if [[ -d {} ]]; then
      eza --tree --level=2 --color=always --icons=auto {}
    else
      bat --style=numbers,changes --color=always --line-range=:200 {}
    fi
  '
  --bind='ctrl-e:become(\${EDITOR:-nvim} {+})'
  --bind='ctrl-y:execute-silent(wl-copy -- {+} 2>/dev/null || xclip -selection clipboard <<< {+} 2>/dev/null)+bell'
"

# ══════════════════════════════════════════════════════════════════════════════
# FZF — Alt+C: directory jumper
# ══════════════════════════════════════════════════════════════════════════════
export FZF_ALT_C_OPTS="
  --scheme=path
  --input-label=' Jump '
  --walker-skip=.git,node_modules,.cache
  --header='  Jump to directory'
  --header-border=bottom
  --preview='eza --tree --level=3 --color=always --icons=auto {}'
  --preview-window=right:55%:border-rounded
"

# ══════════════════════════════════════════════════════════════════════════════
# FZF — Ctrl+R: history (atuin owns this; fzf is fallback for SSH/minimal)
# ══════════════════════════════════════════════════════════════════════════════
export FZF_CTRL_R_OPTS="
  --scheme=history
  --highlight-line
  --input-label=' History '
  --preview='echo -- {}'
  --preview-window=down:4:hidden:wrap
  --bind='ctrl-/:toggle-preview'
  --bind='ctrl-y:execute-silent(wl-copy -- {} 2>/dev/null || xclip -selection clipboard <<< {} 2>/dev/null)+bell'
  --header='  CTRL-Y: copy  CTRL-/: expand'
  --header-border=bottom
"

# ══════════════════════════════════════════════════════════════════════════════
# FZF — smart ** completion previews
# ══════════════════════════════════════════════════════════════════════════════
_fzf_comprun() {
  local command=$1; shift
  case "$command" in
    cd)           fzf --scheme=path \
                      --preview 'eza --tree --level=3 --color=always --icons=auto {}' "$@" ;;
    ssh)          fzf --preview 'dig +short {} 2>/dev/null || echo "(no DNS record)"' "$@" ;;
    export|unset) fzf --preview "eval 'echo \${{}:-<unset>}'" "$@" ;;
    nvim|vim|hx)  fzf --scheme=path \
                      --preview 'bat --style=numbers,changes --color=always --line-range=:200 {}' "$@" ;;
    kill)         fzf --preview 'ps --pid={} -o pid,user,pcpu,pmem,cmd --no-headers -w 2>/dev/null' "$@" ;;
    source|.)     fzf --preview 'bat --style=numbers --color=always --line-range=:100 {}' "$@" ;;
    *)            fzf --scheme=path \
                      --preview '[[ -d {} ]] \
                        && eza --tree --level=2 --color=always --icons=auto {} \
                        || bat --style=numbers,changes --color=always --line-range=:100 {}' "$@" ;;
  esac
}

# ══════════════════════════════════════════════════════════════════════════════
# vivid — LS_COLORS (catppuccin-mocha built-in since vivid 0.9)
# ══════════════════════════════════════════════════════════════════════════════
if command -v vivid &>/dev/null; then
  export LS_COLORS="$(vivid generate catppuccin-mocha 2>/dev/null \
                      || vivid generate snazzy 2>/dev/null)"
else
  command -v dircolors &>/dev/null \
    && eval "$(dircolors -b ~/.dircolors 2>/dev/null || dircolors -b)"
fi

# ══════════════════════════════════════════════════════════════════════════════
# carapace-bin (yay -S carapace-bin)
# ══════════════════════════════════════════════════════════════════════════════
# CARAPACE_BRIDGES: defer to native zsh completions when they exist (_pacman,
# _yay, _git, etc.). 'inshellisense' omitted — requires a running HTTP server
# and adds ~200ms latency per completion when absent.
if command -v carapace &>/dev/null; then
  export CARAPACE_BRIDGES='zsh,fish,bash'
  zsh-defer -c '_cached_eval carapace _carapace zsh'
fi

# ══════════════════════════════════════════════════════════════════════════════
# navi — interactive cheatsheet browser (yay -S navi)
# ══════════════════════════════════════════════════════════════════════════════
if command -v navi &>/dev/null; then
  _navi_widget() {
    local _result
    _result=$(
      navi --print --query "$BUFFER" \
           --fzf-overrides "--height=80% --border=rounded --prompt='navi ❯ '"
    ) 2>/dev/null
    if [[ -n $_result ]]; then
      BUFFER="$_result"
      CURSOR=${#BUFFER}
    fi
    zle reset-prompt
  }
  zle -N _navi_widget
  bindkey -M emacs '^X^N' _navi_widget
  bindkey -M viins '^X^N' _navi_widget
fi

# ══════════════════════════════════════════════════════════════════════════════
# direnv — per-directory environment (yay -S direnv)
# ══════════════════════════════════════════════════════════════════════════════
if command -v direnv &>/dev/null; then
  zsh-defer -c '_cached_eval direnv hook zsh'
fi

# ══════════════════════════════════════════════════════════════════════════════
# mise — polyglot runtime manager (yay -S mise)
# ══════════════════════════════════════════════════════════════════════════════
if command -v mise &>/dev/null; then
  zsh-defer -c '_cached_eval mise activate zsh'
fi

# ══════════════════════════════════════════════════════════════════════════════
# Starship — synchronous (precmd hook must register before first prompt)
# ══════════════════════════════════════════════════════════════════════════════
command -v starship &>/dev/null \
  || curl -sS https://starship.rs/install.sh | sh -s -- --yes --bin-dir "$HOME/.local/bin"
_cached_eval starship init zsh

# ══════════════════════════════════════════════════════════════════════════════
# Async tools
# ══════════════════════════════════════════════════════════════════════════════

# zoxide: frecency-aware cd replacement (z, zi)
zsh-defer -c '_cached_eval zoxide init zsh --cmd cd'

# Atuin: cross-session history with optional sync.
# --disable-up-arrow: zsh-history-substring-search owns ↑ for prefix search.
zsh-defer -c '_cached_eval atuin init zsh --disable-up-arrow'

# Rebuild PATH hash once asynchronously.
zsh-defer rehash
