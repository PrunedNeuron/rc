# fzf/defaults.zsh — Global FZF options and Catppuccin Mocha colour palette.
# Per-command opts (CTRL_T, ALT_C, CTRL_R) live in fzf/commands.zsh.
# fzf-tab zstyle lives in fzf/tab.zsh.

# ── Source commands ───────────────────────────────────────────────────────────
export FZF_DEFAULT_COMMAND='fd --type f --hidden --follow --exclude .git'
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_ALT_C_COMMAND='fd --type d --hidden --follow --exclude .git'
export FZF_COMPLETION_DIR_COMMANDS='cd pushd rmdir tree eza ls'

# ── Catppuccin Mocha palette ──────────────────────────────────────────────────
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

# Popup geometry only makes sense inside tmux; plain --height is the fallback.
[[ -n $TMUX ]] && _fzf_tmux_flag='--tmux center,85%' || _fzf_tmux_flag=''

# ── FZF_DEFAULT_OPTS ──────────────────────────────────────────────────────────
# HARD CONSTRAINTS — never change these:
#   (1) NO --bind=tab:accept   — breaks fzf-tab's continuous-trigger
#   (2) NO --multi             — breaks fzf-tab's Tab-to-accept workflow
#   (3) NO clipboard bindings  — fire spuriously during fzf-tab completions
#   (4) NO --scheme globally   — scheme is per-context, set in commands.zsh
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
unset _fzf_mocha _fzf_tmux_flag