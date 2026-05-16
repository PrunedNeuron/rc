# fzf/commands.zsh — Per-command FZF option overrides and _fzf_comprun.

# ── Ctrl+T: file picker ───────────────────────────────────────────────────────
export FZF_CTRL_T_OPTS="
  --multi
  --scheme=path
  --input-label=' Files '
  --walker-skip=.git,node_modules,.cache,.venv,__pycache__
  --header='  Ctrl+E: edit  Ctrl+Y: copy  Ctrl+/: preview  Ctrl+A: select all'
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

# ── Alt+C: directory jumper ───────────────────────────────────────────────────
export FZF_ALT_C_OPTS="
  --scheme=path
  --input-label=' Jump '
  --walker-skip=.git,node_modules,.cache
  --header='  Jump to directory'
  --header-border=bottom
  --preview='eza --tree --level=3 --color=always --icons=auto {}'
  --preview-window=right:55%:border-rounded
"

# ── Ctrl+R: history (atuin overrides this; fzf is the SSH/minimal fallback) ───
export FZF_CTRL_R_OPTS="
  --scheme=history
  --highlight-line
  --input-label=' History '
  --preview='echo -- {}'
  --preview-window=down:4:hidden:wrap
  --bind='ctrl-/:toggle-preview'
  --bind='ctrl-y:execute-silent(wl-copy -- {} 2>/dev/null || xclip -selection clipboard <<< {} 2>/dev/null)+bell'
  --header='  Ctrl+Y: copy  Ctrl+/: expand'
  --header-border=bottom
"

# ── Smart ** completion previews ──────────────────────────────────────────────
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