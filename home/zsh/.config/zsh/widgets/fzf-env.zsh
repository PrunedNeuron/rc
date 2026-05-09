# $ZCONFDIR/widgets/fzf-env.zsh — fuzzy environment variable browser. Alt+E.
#
# Actions:
#   Enter       insert $VAR_NAME at cursor
#   Ctrl+V      insert the variable's value at cursor
#   Ctrl+Y      copy value to clipboard
#   Ctrl+/      toggle preview

_fzf_env_browser() {
  # Two-pass approach: first selection returns name=value line.
  # We capture the full line to derive both name and value without re-invoking env.
  local selected
  selected=$(
    env | sort \
    | fzf \
        --prompt='env ❯ ' \
        --input-label=' Environment ' \
        --header='  Enter: insert name  Ctrl+V: insert value  Ctrl+Y: copy value' \
        --header-border=bottom \
        --delimiter='=' \
        --preview='
          name={1}
          val=${(P)name}
          echo "── Name ───────────────────────────────────────────"
          echo "$name"
          echo
          echo "── Value ──────────────────────────────────────────"
          if [[ ${#val} -gt 400 ]]; then
            echo "${val:0:400}…"
          else
            echo "$val"
          fi
          echo
          if [[ "$val" == *:* ]]; then
            echo "── Colon-delimited entries ────────────────────────"
            echo "$val" | tr ":" "\n" | nl -ba
          fi
        ' \
        --preview-window='right:55%:border-rounded:wrap' \
        --bind='ctrl-/:toggle-preview' \
        --bind='ctrl-y:execute-silent(
          name={1}; val="${(P)name}"
          echo -n "$val" | wl-copy 2>/dev/null || echo -n "$val" | xclip -selection clipboard 2>/dev/null
        )+bell' \
        --expect='ctrl-v'
  )

  [[ -z $selected ]] && { zle reset-prompt; return }

  # When --expect fires, fzf prepends the key on a separate line.
  local key line
  if [[ ${#${(f)selected}} -gt 1 ]]; then
    key="${${(f)selected}[1]}"
    line="${${(f)selected}[2]}"
  else
    key=''
    line="$selected"
  fi

  local varname="${line%%=*}"
  local varval="${(P)varname}"

  if [[ $key == 'ctrl-v' ]]; then
    LBUFFER+="$varval"
  else
    LBUFFER+="$varname"
  fi
  zle reset-prompt
}

zle -N _fzf_env_browser
bindkey -M emacs '^[e' _fzf_env_browser
bindkey -M viins '^[e' _fzf_env_browser
bindkey -M vicmd '^[e' _fzf_env_browser
