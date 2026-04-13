# $ZCONFDIR/widgets/fzf-ssh.zsh
#
# Fuzzy SSH host picker. Alt+N (Network).
# Sources hosts from ~/.ssh/config, /etc/hosts, and known_hosts.
#
# Actions:
#   Enter       ssh to selected host (inserts into buffer or connects directly)
#   Ctrl+Y      copy hostname to clipboard
#   Ctrl+E      open ~/.ssh/config in $EDITOR
#   Ctrl+/      toggle preview

_fzf_ssh_picker() {
  # Merge all known host sources
  local -a hosts

  # ~/.ssh/config: extract Host entries (excluding wildcards)
  if [[ -r ~/.ssh/config ]]; then
    hosts+=(${(f)"$(
      grep -i '^host' ~/.ssh/config \
      | awk '{print $2}' \
      | grep -v '[*?]'
    )"})
  fi

  # /etc/hosts: non-comment, non-localhost lines
  hosts+=(${(f)"$(
    awk '/^[^#]/ && $2 !~ /localhost|broadcasthost/ {print $2}' /etc/hosts 2>/dev/null
  )"})

  # ~/.ssh/known_hosts: extract hostnames (strip port notation and hashed entries)
  if [[ -r ~/.ssh/known_hosts ]]; then
    hosts+=(${(f)"$(
      awk '{print $1}' ~/.ssh/known_hosts \
      | grep -v '^\[' \
      | grep -v '|' \
      | tr ',' '\n' \
      | grep -v '^$'
    )"})
  fi

  # Deduplicate
  hosts=(${(u)hosts})

  [[ ${#hosts} -eq 0 ]] && {
    print -P '%F{yellow}No SSH hosts found in config or known_hosts.%f'
    zle reset-prompt
    return
  }

  local selected
  selected=$(
    printf '%s\n' "${hosts[@]}" \
    | sort -u \
    | fzf \
        --prompt='ssh ❯ ' \
        --header='Enter: connect  Ctrl+Y: copy  Ctrl+E: edit config  Ctrl+/: preview' \
        --preview='
          host={}
          echo "── SSH Config ─────────────────────────────────────"
          grep -A15 -i "^Host[[:space:]]\+$host\b" ~/.ssh/config 2>/dev/null \
            || echo "(no specific config block)"
          echo
          echo "── DNS ────────────────────────────────────────────"
          dig +short "$host" 2>/dev/null || host "$host" 2>/dev/null || echo "(no DNS)"
          echo
          echo "── Ping (1 packet) ────────────────────────────────"
          ping -c1 -W1 "$host" 2>/dev/null | tail -2 || echo "(unreachable)"
        ' \
        --preview-window='right:55%:border-rounded:wrap' \
        --bind='ctrl-/:toggle-preview' \
        --bind="ctrl-e:execute(${EDITOR:-nvim} ~/.ssh/config </dev/tty >/dev/tty)" \
        --bind='ctrl-y:execute-silent(echo -n {} | wl-copy 2>/dev/null)+bell'
  )

  if [[ -n $selected ]]; then
    # Insert the ssh command into the buffer rather than executing directly —
    # lets the user add flags before pressing Enter.
    BUFFER="ssh $selected"
    CURSOR=${#BUFFER}
  fi
  zle reset-prompt
}
zle -N _fzf_ssh_picker
bindkey -M emacs '^[n' _fzf_ssh_picker
bindkey -M viins '^[n' _fzf_ssh_picker
bindkey -M vicmd '^[n' _fzf_ssh_picker
