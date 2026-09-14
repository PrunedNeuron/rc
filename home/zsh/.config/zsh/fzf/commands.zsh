# fzf/commands.zsh — Per-widget fzf options and ** completion previews.

# ══════════════════════════════════════════════════════════════════════════════
# Ctrl+T — file/directory picker
# ══════════════════════════════════════════════════════════════════════════════
export FZF_CTRL_T_OPTS="
  --multi
  --scheme=path
  --input-label=' Files '
  --header='  Ctrl+E: edit  Ctrl+Y: copy  Ctrl+/: preview  Ctrl+A: select all'
  --header-border=bottom
  --preview='
    if [[ -d {} ]]; then
      eza --tree --level=2 --color=always --icons=auto {} 2>/dev/null || ls -la -- {}
    else
      bat --style=numbers,changes --color=always --line-range=:200 -- {} 2>/dev/null || file --brief -- {}
    fi
  '
  --bind='ctrl-e:become(\${EDITOR:-nvim} {+})'
  --bind='ctrl-y:execute-silent(printf '%s\n' {+} | (wl-copy 2>/dev/null || xclip -selection clipboard 2>/dev/null))+bell'
"

# ══════════════════════════════════════════════════════════════════════════════
# Alt+C — directory jumper
# ══════════════════════════════════════════════════════════════════════════════
export FZF_ALT_C_OPTS="
  --scheme=path
  --input-label=' Jump '
  --header='  Jump to directory'
  --header-border=bottom
  --preview='eza --tree --level=3 --color=always --icons=auto {} 2>/dev/null || ls -la -- {}'
  --preview-window=right:55%:border-rounded
"

# ══════════════════════════════════════════════════════════════════════════════
# Ctrl+R — native fzf history fallback
# ══════════════════════════════════════════════════════════════════════════════
# Atuin takes Ctrl+R once its deferred integration loads. This remains available
# as the native fzf fallback (e.g. minimal/SSH sessions where Atuin is absent).
export FZF_CTRL_R_OPTS="
  --scheme=history
  --highlight-line
  --input-label=' History '
  --preview='printf %s\\n {}'
  --preview-window=down:4:hidden:wrap
  --bind='ctrl-/:toggle-preview'
  --bind='ctrl-y:execute-silent(printf '%s\n' {} | (wl-copy 2>/dev/null || xclip -selection clipboard 2>/dev/null))+bell'
  --header='  Ctrl+Y: copy  Ctrl+/: expand'
  --header-border=bottom
"

# ══════════════════════════════════════════════════════════════════════════════
# Smart ** completion previews
# ══════════════════════════════════════════════════════════════════════════════
_fzf_comprun() {
  local command=$1
  shift

  case "$command" in
    cd|pushd|rmdir)
      fzf --scheme=path \
          --preview 'eza --tree --level=3 --color=always --icons=auto {} 2>/dev/null || ls -la -- {}' \
          "$@"
      ;;

    ssh|scp|sftp)
      fzf --preview 'ssh -G {} 2>/dev/null | head -40 || printf "(no SSH config)\\n"' "$@"
      ;;

    export|unset)
      fzf --preview 'printenv -- {} 2>/dev/null || printf "<unset>\\n"' "$@"
      ;;

    nvim|vim|vi|hx|nano|code)
      fzf --scheme=path \
          --preview 'bat --style=numbers,changes --color=always --line-range=:200 -- {} 2>/dev/null || file --brief -- {}' \
          "$@"
      ;;

    kill|killall|pkill)
      fzf --preview 'ps --pid={} -o pid,user,pcpu,pmem,cmd --no-headers -w 2>/dev/null' "$@"
      ;;

    source|.)
      fzf --scheme=path \
          --preview 'bat --style=numbers --color=always --line-range=:120 -- {} 2>/dev/null || file --brief -- {}' \
          "$@"
      ;;

    *)
      fzf --scheme=path \
          --preview 'if [[ -d {} ]]; then eza --tree --level=2 --color=always --icons=auto {} 2>/dev/null || ls -la -- {}; else bat --style=numbers,changes --color=always --line-range=:120 -- {} 2>/dev/null || file --brief -- {}; fi' \
          "$@"
      ;;
  esac
}
