# $ZCONFDIR/plugins.zsh — external tool integration.
# zsh-defer is available after init/post.zsh sources ZIM_HOME/init.zsh.

# ══════════════════════════════════════════════════════════════════════════════
# Startup cache helper
# ══════════════════════════════════════════════════════════════════════════════
# Caches stdout of a tool's init command; invalidates when binary is newer.
# Write-locks via temp-file-rename to prevent partial reads on concurrent starts.
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
# Install Catppuccin Mocha theme: mkdir -p "$(bat --config-dir)/themes"
# Place Catppuccin-mocha.tmTheme there, then: bat cache --build
export BAT_THEME='Catppuccin-mocha'

# ══════════════════════════════════════════════════════════════════════════════
# zsh-autosuggestions
# ══════════════════════════════════════════════════════════════════════════════
# Strategy order: prefer history first, fall back to completion engine
ZSH_AUTOSUGGEST_STRATEGY=(history completion)
ZSH_AUTOSUGGEST_BUFFER_MAX_SIZE=20      # no suggestions for very long lines
ZSH_AUTOSUGGEST_USE_ASYNC=1             # async fetch — no input lag
# Catppuccin Mocha surface2 (#585b70) — visible but clearly secondary
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=#585b70,italic'

# ══════════════════════════════════════════════════════════════════════════════
# zsh-history-substring-search
# ══════════════════════════════════════════════════════════════════════════════
HISTORY_SUBSTRING_SEARCH_FUZZY=1                  # fuzzy matching (not just prefix)
HISTORY_SUBSTRING_SEARCH_ENSURE_UNIQUE=1          # skip duplicates in results
HISTORY_SUBSTRING_SEARCH_HIGHLIGHT_FOUND='bg=#313244,fg=#cba6f7,bold'    # Catppuccin
HISTORY_SUBSTRING_SEARCH_HIGHLIGHT_NOT_FOUND='bg=#313244,fg=#f38ba8,bold' # Catppuccin

# ══════════════════════════════════════════════════════════════════════════════
# zsh-you-should-use
# ══════════════════════════════════════════════════════════════════════════════
export YSU_MESSAGE_POSITION="after"    # hint appears after output, not before
export YSU_MODE=ALL                    # check regular, global, and suffix aliases
export YSU_IGNORED_ALIASES=('g' 'l' 's')  # skip single-char aliases — too trivial

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
export ABBR_SET_EXPANSION_CURSOR=1                 # cursor lands at % marker
export ABBR_EXPAND_PUSH_ABBREVIATION_TO_HISTORY=1  # history records expanded form

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
)

# ══════════════════════════════════════════════════════════════════════════════
# FZF — source commands
# ══════════════════════════════════════════════════════════════════════════════
# fd: .gitignore-aware, symlink-following, substantially faster than find(1).
# fzf 0.59+ built-in walker is used as fallback when fd is absent.
export FZF_DEFAULT_COMMAND='fd --type f --hidden --follow --exclude .git'
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_ALT_C_COMMAND='fd --type d --hidden --follow --exclude .git'

# ══════════════════════════════════════════════════════════════════════════════
# FZF — global defaults (FZF_DEFAULT_OPTS)
# ══════════════════════════════════════════════════════════════════════════════
#
# CRITICAL CONSTRAINTS:
#   (1) NO --bind=tab:accept here — breaks fzf-tab's continuous-trigger.
#   (2) NO --multi here — would break fzf-tab's Tab-to-accept workflow.
#       Multi-select is enabled per-context (fzf-tab flags, CTRL_T_OPTS, etc.)
#   (3) NO clipboard bindings here — they fire during fzf-tab completions.
#
# --scheme is set per-context (path/history) not globally.

export FZF_DEFAULT_OPTS="
  --height=60%
  --tmux center,85%
  --layout=reverse
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
unset _fzf_mocha

# ══════════════════════════════════════════════════════════════════════════════
# FZF — Ctrl+T: file picker
# ══════════════════════════════════════════════════════════════════════════════
export FZF_CTRL_T_OPTS="
  --multi
  --scheme=path
  --walker-skip=.git,node_modules,.cache,.venv,__pycache__
  --header='CTRL-E: edit  CTRL-Y: copy  CTRL-/: preview  CTRL-A: mark all  CTRL-SPACE: mark'
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
  --walker-skip=.git,node_modules,.cache
  --header='Jump to directory'
  --preview='eza --tree --level=3 --color=always --icons=auto {}'
  --preview-window=right:55%:border-rounded
"

# ══════════════════════════════════════════════════════════════════════════════
# FZF — Ctrl+R: history (atuin overrides this; fallback for SSH/minimal envs)
# ══════════════════════════════════════════════════════════════════════════════
export FZF_CTRL_R_OPTS="
  --scheme=history
  --highlight-line
  --preview='echo -- {}'
  --preview-window=down:4:hidden:wrap
  --bind='ctrl-/:toggle-preview'
  --bind='ctrl-r:toggle-sort'
  --bind='ctrl-y:execute-silent(wl-copy -- {} 2>/dev/null || xclip -selection clipboard <<< {} 2>/dev/null)+bell'
  --header='CTRL-Y: copy  CTRL-/: expand  CTRL-R: toggle sort'
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
# vivid — rich LS_COLORS from Catppuccin Mocha theme
# ══════════════════════════════════════════════════════════════════════════════
# vivid is in the Arch repos: pacman -S vivid
# It generates a much richer LS_COLORS than dircolors, covering 200+ file types.
# This runs synchronously because LS_COLORS must be set before the first prompt
# and before the `sched 0 _set_list_colors` call in styles.zsh takes effect.
VIVID_THEME='snazzy' # Check `vivid themes`
if command -v vivid &>/dev/null; then
  export LS_COLORS="$(vivid generate "$VIVID_THEME" 2>/dev/null \
                      || vivid generate molokai 2>/dev/null)"
else
  # Fallback: GNU dircolors with 256-colour support
  command -v dircolors &>/dev/null \
    && eval "$(dircolors -b ~/.dircolors 2>/dev/null || dircolors -b)"
fi

# ══════════════════════════════════════════════════════════════════════════════
# carapace-bin — 1000+ command completions (yay -S carapace-bin)
# ══════════════════════════════════════════════════════════════════════════════
# CARAPACE_BRIDGES='zsh' makes carapace defer to native zsh completions when
# they exist (_pacman, _yay, _git, _nvim, …), only filling the gap for tools
# without native completions. This is the correct and safe integration mode.
#
# Deferred via zsh-defer so carapace's compdef registrations happen after
# compinit (already run in init/post.zsh). _cached_eval caches the init script
# and invalidates automatically when the carapace binary is updated.
if command -v carapace &>/dev/null; then
  export CARAPACE_BRIDGES='zsh,fish,bash,inshellisense'
  # Use a slightly different cache key so it doesn't conflict with other evals
  zsh-defer -c '_cached_eval carapace _carapace zsh'
fi

# ══════════════════════════════════════════════════════════════════════════════
# navi — interactive cheatsheet browser (yay -S navi)
# ══════════════════════════════════════════════════════════════════════════════
# Bound to Ctrl+X Ctrl+N (avoids conflict with fzf-git.sh's Ctrl+G default).
# Usage: type a partial command, press the binding to see matching cheatsheets.
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
# zsh-history-substring-search — configured after zim loads the plugin
# ══════════════════════════════════════════════════════════════════════════════
# These vars must be set before or right after the plugin sources, which zim
# does in init.zsh (already sourced by init/post.zsh). Setting them here is safe.
# (already configured in plugins.zsh from previous answer — shown for completeness)
HISTORY_SUBSTRING_SEARCH_FUZZY=1
HISTORY_SUBSTRING_SEARCH_ENSURE_UNIQUE=1
HISTORY_SUBSTRING_SEARCH_HIGHLIGHT_FOUND='bg=#313244,fg=#cba6f7,bold'
HISTORY_SUBSTRING_SEARCH_HIGHLIGHT_NOT_FOUND='bg=#313244,fg=#f38ba8,bold'

# ══════════════════════════════════════════════════════════════════════════════
# Starship — synchronous (registers precmd hook before first prompt render)
# ══════════════════════════════════════════════════════════════════════════════
command -v starship &>/dev/null \
  || curl -sS https://starship.rs/install.sh | sh -s -- --yes --bin-dir "$HOME/.local/bin"
_cached_eval starship init zsh

# ══════════════════════════════════════════════════════════════════════════════
# Async tools (deferred — zsh-defer loaded by init/post.zsh)
# ══════════════════════════════════════════════════════════════════════════════

# zoxide: `--cmd cd` replaces builtin cd with frecency-aware jump
zsh-defer -c '_cached_eval zoxide init zsh --cmd cd'

# Atuin: neural recency+frequency history, optional cross-device sync.
# --disable-up-arrow: zsh-history-substring-search owns ↑ for prefix search.
zsh-defer -c '_cached_eval atuin init zsh --disable-up-arrow'

# Rehash PATH once asynchronously — cheaper than per-tab rehash
zsh-defer rehash
