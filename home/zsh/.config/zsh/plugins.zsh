# $ZCONFDIR/plugins.zsh
# Requires: zsh-defer (loaded by post.zsh / init.zsh before this file is sourced)

# ── Caching helper ────────────────────────────────────────────────────────────
# Caches stdout of an initializer; invalidates when the binary is newer than
# the cache. This saves ~10-30ms per tool on every shell startup.
_cached_eval() {
  local cache="$ZCACHEDIR/eval_${1:t}.zsh"
  local bin; bin=$(whence -p "$1" 2>/dev/null)
  if [[ -z $bin ]]; then
    print -u2 "plugins.zsh: '$1' not found, skipping"
    return 1
  fi
  if [[ ! -s $cache || $cache -ot $bin ]]; then
    mkdir -p "${cache:h}"
    "$@" >| "$cache" 2>/dev/null || { rm -f "$cache"; return 1 }
  fi
  builtin source "$cache"
}

# ── bat ───────────────────────────────────────────────────────────────────────
# Keeps bat's syntax theme consistent with the Catppuccin Mocha fzf palette.
# To install: mkdir -p "$(bat --config-dir)/themes" && <place .tmTheme there>
#             then run: bat cache --build
# Fallback: if the theme is absent, bat silently uses its default.
export BAT_THEME='Catppuccin-mocha'

# ── FZF: source commands ──────────────────────────────────────────────────────
# fd: .gitignore-aware, symlink-following, substantially faster than find(1).
export FZF_DEFAULT_COMMAND='fd --type f --hidden --follow --exclude .git'
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_ALT_C_COMMAND='fd --type d --hidden --follow --exclude .git'

# ── FZF: Catppuccin Mocha palette ─────────────────────────────────────────────
# Split across multiple --color flags; fzf accumulates them additively.
# Explicit gutter/preview-bg/preview-border prevent those elements from
# inheriting the terminal background, which varies by terminal emulator.
_fzf_catppuccin=(
  '--color=bg+:#313244,bg:#1e1e2e,spinner:#f5e0dc,hl:#f38ba8'
  '--color=fg:#cdd6f4,header:#f38ba8,info:#cba6f7,pointer:#f5e0dc'
  '--color=marker:#b4befe,fg+:#cdd6f4,prompt:#cba6f7,hl+:#f38ba8'
  '--color=selected-bg:#45475a,border:#585b70,label:#cdd6f4'
  '--color=preview-bg:#1e1e2e,preview-border:#585b70,preview-label:#cdd6f4'
  '--color=gutter:#1e1e2e,query:#cdd6f4,disabled:#6c7086'
)

# ── FZF: global defaults ──────────────────────────────────────────────────────
# CRITICAL CONSTRAINTS — do not violate:
#
#   (1) NO --bind=tab:accept here. It breaks fzf-tab's continuous-trigger ('/').
#       Tab behaviour for completions is set exclusively in styles.zsh fzf-flags.
#
#   (2) NO clipboard bindings (ctrl-y) here. They fire unexpectedly during fzf-tab
#       completions, copying a candidate to the clipboard instead of inserting it.
#       Clipboard binds are per-widget only: CTRL_T_OPTS and CTRL_R_OPTS below.
#
# --info=inline-right   fzf ≥ 0.44: right-aligns match count (cleaner layout)
# --highlight-line      fzf ≥ 0.53: highlights the entire selected row
# --scroll-off=5        keeps 5 context lines above/below the cursor
# --cycle               wraps selection at list boundaries
# --padding=0,1         prevents text touching the rounded border
# --tmux center,85%     opens in a tmux popup when in tmux; silently ignored otherwise
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
  ${_fzf_catppuccin[@]}
  --preview-window=right:55%:border-rounded:wrap
  --bind=ctrl-space:toggle+down
  --bind=ctrl-a:toggle-all
  --bind=ctrl-/:toggle-preview
  --bind='alt-up:preview-up'
  --bind='alt-down:preview-down'
  --bind='alt-f:preview-page-down'
  --bind='alt-b:preview-page-up'
"
unset _fzf_catppuccin

# ── FZF: Ctrl+T — file picker ─────────────────────────────────────────────────
# --multi       mark multiple files; all inserted on accept
# become()      fzf ≥ 0.47: replaces the fzf process with $EDITOR (no double fork)
# ctrl-y        clipboard binding is safe here; does not interfere with completion
export FZF_CTRL_T_OPTS="
  --multi
  --header='ctrl-e: edit  ctrl-y: copy path  ctrl-/: preview  ctrl-a: mark all'
  --preview='[[ -d {} ]] \
    && eza --tree --level=2 --color=always --icons=auto {} \
    || bat --style=numbers,changes --color=always --line-range=:200 {}'
  --bind='ctrl-e:become(\${EDITOR:-nvim} {+})'
  --bind='ctrl-y:execute-silent(wl-copy -- {+} 2>/dev/null || xclip -selection clipboard <<< {+} 2>/dev/null)+bell'
"

# ── FZF: Alt+C — directory jumper ─────────────────────────────────────────────
export FZF_ALT_C_OPTS="
  --header='Jump to directory'
  --preview='eza --tree --level=3 --color=always --icons=auto {}'
  --preview-window=right:55%:border-rounded
"

# ── FZF: Ctrl+R — history fallback ────────────────────────────────────────────
# Atuin owns Ctrl+R when loaded. This configures the native fzf fallback for
# environments without Atuin (SSH sessions, minimal installs, etc.).
export FZF_CTRL_R_OPTS="
  --preview='echo -- {}'
  --preview-window=down:3:hidden:wrap
  --bind='ctrl-/:toggle-preview'
  --bind='ctrl-y:execute-silent(wl-copy -- {} 2>/dev/null || xclip -selection clipboard <<< {} 2>/dev/null)+bell'
  --header='ctrl-y: copy command  ctrl-/: expand preview'
"

# ── FZF: smart ** completion previews ─────────────────────────────────────────
# _fzf_comprun is called by fzf's zsh integration for **-triggered completions.
# $1 = the command being completed; remaining args are forwarded to fzf.
_fzf_comprun() {
  local command=$1; shift
  case "$command" in
    cd)           fzf --preview 'eza --tree --level=3 --color=always --icons=auto {}' "$@" ;;
    ssh)          fzf --preview 'dig +short {} 2>/dev/null || echo "(no DNS record)"' "$@" ;;
    export|unset) fzf --preview "eval 'echo \${{}:-<unset>}'" "$@" ;;
    nvim|vim|hx)  fzf --preview 'bat --style=numbers,changes --color=always --line-range=:200 {}' "$@" ;;
    kill)         fzf --preview 'ps --pid={} -o pid,user,pcpu,pmem,cmd --no-headers -w 2>/dev/null' "$@" ;;
    source|.)     fzf --preview 'bat --style=numbers --color=always --line-range=:100 {}' "$@" ;;
    *)            fzf --preview '[[ -d {} ]] \
                    && eza --tree --level=2 --color=always --icons=auto {} \
                    || bat --style=numbers,changes --color=always --line-range=:100 {}' "$@" ;;
  esac
}

# ── zsh-abbr tuning ───────────────────────────────────────────────────────────
# After expansion, place the cursor at the % marker rather than end-of-line.
# Usage: abbr gcm='git commit -m "%"'  → cursor lands between the quotes.
export ABBR_SET_EXPANSION_CURSOR=1

# Store the *expanded* form in history, not the abbreviation.
# gco<Enter> → history records 'git checkout', not 'gco'.
# Makes history portable across machines without your abbr config.
export ABBR_EXPAND_PUSH_ABBREVIATION_TO_HISTORY=1

# ── Starship ──────────────────────────────────────────────────────────────────
# Synchronous: must register its precmd hook before the first prompt renders.
command -v starship &>/dev/null \
  || curl -sS https://starship.rs/install.sh | sh -s -- --yes --bin-dir "$HOME/.local/bin"
_cached_eval starship init zsh

# ── Zoxide ────────────────────────────────────────────────────────────────────
zsh-defer -c '_cached_eval zoxide init zsh'

# ── Atuin ─────────────────────────────────────────────────────────────────────
# --disable-up-arrow: zsh-history-substring-search owns ↑ for prefix search.
# Atuin handles Ctrl+R with neural frequency/recency ranking and optional sync.
zsh-defer -c '_cached_eval atuin init zsh --disable-up-arrow'

# PATH rehash once asynchronously — far cheaper than per-tab rehash.
zsh-defer rehash
