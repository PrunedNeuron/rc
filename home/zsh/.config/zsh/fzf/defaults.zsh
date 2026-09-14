# fzf/defaults.zsh — Global fzf defaults and Catppuccin Mocha palette.
# Native fzf shell widgets use these defaults. fzf-tab intentionally does NOT
# inherit FZF_DEFAULT_OPTS; its equivalent scoped configuration lives in tab.zsh.

# ══════════════════════════════════════════════════════════════════════════════
# Candidate sources
# ══════════════════════════════════════════════════════════════════════════════
# Keep fd for deterministic filtering and explicit ignore policy.
export FZF_DEFAULT_COMMAND='fd --type f --hidden --follow --exclude .git --exclude node_modules --exclude .cache --exclude .venv --exclude __pycache__'

# Ctrl+T should accept both files and directories, matching fzf's native widget.
export FZF_CTRL_T_COMMAND='fd --hidden --follow --exclude .git --exclude node_modules --exclude .cache --exclude .venv --exclude __pycache__'

# Alt+C is directory-only.
export FZF_ALT_C_COMMAND='fd --type d --hidden --follow --exclude .git --exclude node_modules --exclude .cache --exclude .venv --exclude __pycache__'

# Commands eligible for fzf's ** path completion.
export FZF_COMPLETION_DIR_COMMANDS='cd pushd rmdir tree eza ls'

# ══════════════════════════════════════════════════════════════════════════════
# Catppuccin Mocha
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

# fzf's native --tmux popup is ignored outside tmux, so keep a normal --height
# fallback and add the popup only when tmux is actually present.
_fzf_tmux_flag=''
[[ -n ${TMUX-} ]] && _fzf_tmux_flag='--tmux=center,85%'
_fzf_wrap_sign=$'\t↳ '

# ══════════════════════════════════════════════════════════════════════════════
# Global options
# ══════════════════════════════════════════════════════════════════════════════
# Intentionally absent globally:
#   --multi              native widgets choose this per context
#   --bind=tab:accept    would interfere with fzf's own multi-select semantics
#   --scheme             path/history/default are context-specific
#   clipboard actions    are context-specific
export FZF_DEFAULT_OPTS="
  --height=60%
  ${_fzf_tmux_flag}
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
  --wrap-sign='${_fzf_wrap_sign}'
  ${_fzf_mocha[@]}
  --preview-window=right:55%:border-rounded:wrap
  --bind='ctrl-space:toggle+down'
  --bind='ctrl-a:toggle-all'
  --bind='ctrl-/:toggle-preview'
  --bind='alt-up:preview-up'
  --bind='alt-down:preview-down'
  --bind='alt-f:preview-page-down'
  --bind='alt-b:preview-page-up'
  --bind='alt-e:preview-top'
  --bind='alt-E:preview-bottom'
  --bind='ctrl-s:toggle-sort'
"

unset _fzf_mocha _fzf_tmux_flag _fzf_wrap_sign
