# $ZCONFDIR/widgets/fzf-ssh.zsh — fuzzy SSH host picker. Alt+N (Network).
#
# Host sources (merged and deduplicated):
#   ~/.ssh/config         Host stanzas (wildcards excluded)
#   /etc/hosts            Non-comment, non-localhost entries
#   ~/.ssh/known_hosts    Hostnames (hashed entries and port-brackets excluded)
#
# Actions:
#   Enter     insert `ssh <host>` into buffer (user can add flags before Enter)
#   Ctrl+Y    copy hostname to clipboard
#   Ctrl+E    open ~/.ssh/config in $EDITOR
#   Ctrl+/    toggle preview (config block + DNS + ping)

_fzf_ssh_picker() {
  local -a hosts=()

  # ~/.ssh/config
  if [[ -r ~/.ssh/config ]]; then
    hosts+=(${(f)"$(
      grep -iE '^[[:space:]]*Host[[:space:]]+' ~/.ssh/config \
      | awk '{for(i=2;i<=NF;i++) print $i}' \
      | grep -v '[*?!]'
    )"})
  fi

  # ~/.ssh/conf.d/* (common pattern for split configs)
  for _f in ~/.ssh/conf.d/*.conf(N); do
    hosts+=(${(f)"$(
      grep -iE '^[[:space:]]*Host[[:space:]]+' "$_f" \
      | awk '{for(i=2;i<=NF;i++) print $i}' \
      | grep -v '[*?!]'
    )"})
  done
  unset _f

  # /etc/hosts
  hosts+=(${(f)"$(
    awk '/^[^#]/ && $2 !~ /localhost|broadcasthost|localdomain/ {print $2}' \
      /etc/hosts 2>/dev/null
  )"})

  # ~/.ssh/known_hosts (skip hashed lines and bracket notation)
  if [[ -r ~/.ssh/known_hosts ]]; then
    hosts+=(${(f)"$(
      awk '{print $1}' ~/.ssh/known_hosts \
      | grep -v '^\[' \
      | grep -v '|' \
      | tr ',' '\n' \
      | grep -vE '^$'
    )"})
  fi

  # Deduplicate, sort
  hosts=(${(u)hosts})
  (( ${#hosts} == 0 )) && {
    zle -M 'No SSH hosts found.'
    zle reset-prompt
    return
  }

  local selected
  selected=$(
    printf '%s\n' "${hosts[@]}" \
    | sort -u \
    | fzf \
        --prompt='ssh ❯ ' \
        --input-label=' SSH Hosts ' \
        --header='  Enter: connect  Ctrl+Y: copy  Ctrl+E: edit config' \
        --header-border=bottom \
        --bind="load:transform-footer:echo ' \$FZF_TOTAL_COUNT hosts'" \
        --footer-border=top \
        --preview='
          host={}
          echo "── SSH Config ─────────────────────────────────────"
          grep -A20 -iE "^[[:space:]]*Host[[:space:]]+$host\b" \
            ~/.ssh/config ~/.ssh/conf.d/*.conf 2>/dev/null \
          | head -25 \
          || echo "(no config block)"
          echo
          echo "── DNS ────────────────────────────────────────────"
          dig +short "$host" 2>/dev/null | head -5 || echo "(no DNS)"
          echo
          echo "── Ping (1 packet, 1s timeout) ────────────────────"
          ping -c1 -W1 "$host" 2>/dev/null | tail -2 || echo "(unreachable)"
        ' \
        --preview-window='right:55%:border-rounded:wrap' \
        --bind='ctrl-/:toggle-preview' \
        --bind="ctrl-e:execute(${EDITOR:-nvim} ~/.ssh/config </dev/tty >/dev/tty)" \
        --bind='ctrl-y:execute-silent(echo -n {} | wl-copy 2>/dev/null)+bell'
  )

  if [[ -n $selected ]]; then
    BUFFER="ssh $selected"
    CURSOR=${#BUFFER}
  fi
  zle reset-prompt
}

zle -N _fzf_ssh_picker
bindkey -M emacs '^[n' _fzf_ssh_picker
bindkey -M viins '^[n' _fzf_ssh_picker
bindkey -M vicmd '^[n' _fzf_ssh_picker
