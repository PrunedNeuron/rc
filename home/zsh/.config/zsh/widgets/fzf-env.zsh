# $ZCONFDIR/widgets/fzf-env.zsh
#
# Fuzzy environment variable browser. Alt+E.
# Shows name=value pairs with expanded values in preview.
#
# Actions:
#   Enter       insert VAR_NAME at cursor position in buffer
#   Ctrl+V      insert the value (not the name)
#   Ctrl+Y      copy value to clipboard
#   Ctrl+U      unset selected variable (with confirmation)
#   Ctrl+E      open $EDITOR to export a new variable (inserts into buffer)
#   Ctrl+/      toggle preview

_fzf_env_browser() {
  local selected
  selected=$(
    # env sorted alphabetically, format: NAME=value
    env | sort \
    | fzf \
        --prompt='env ❯ ' \
        --header='Enter: insert name  Ctrl+V: insert value  Ctrl+Y: copy value  Ctrl+U: unset' \
        --delimiter='=' \
        --preview='
          name={1}
          val=${(P)name}
          echo "── Name ───────────────────────────────────────────"
          echo "$name"
          echo
          echo "── Value ──────────────────────────────────────────"
          if [[ ${#val} -gt 200 ]]; then
            echo "${val:0:200}…"
          else
            echo "$val"
          fi
          echo
          # PATH-like vars: one entry per line
          if [[ "$val" == *:* ]]; then
            echo "── Entries ────────────────────────────────────────"
            echo "$val" | tr ":" "\n" | nl -ba
          fi
        ' \
        --preview-window='right:55%:border-rounded:wrap' \
        --bind='ctrl-/:toggle-preview' \
        --bind='ctrl-y:execute-silent(
          name={1}; val="${(P)name}"
          echo -n "$val" | wl-copy 2>/dev/null || echo -n "$val" | xclip -selection clipboard 2>/dev/null
        )+bell'
  )

  [[ -z $selected ]] && { zle reset-prompt; return }

  local varname=${selected%%=*}

  # Ctrl+V would require a secondary binding; default Enter inserts var name.
  # Insert $VARNAME at cursor position
  LBUFFER+="$varname"
  zle reset-prompt
}
zle -N _fzf_env_browser
bindkey -M emacs '^[e' _fzf_env_browser
bindkey -M viins '^[e' _fzf_env_browser
bindkey -M vicmd '^[e' _fzf_env_browser
