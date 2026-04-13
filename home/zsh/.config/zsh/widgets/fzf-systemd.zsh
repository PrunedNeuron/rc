# $ZCONFDIR/widgets/fzf-systemd.zsh
#
# Interactive systemd service manager. Alt+S opens the hub.
#
# Service browser actions (inside fzf):
#   Ctrl+S   start unit       Ctrl+T   stop unit
#   Ctrl+E   enable unit      Ctrl+D   disable unit
#   Ctrl+R   restart unit     Ctrl+L   live log stream (journalctl -fu)
#   Ctrl+/   toggle preview   Ctrl+Y   copy unit name
#   Enter    show full status in pager
#
# Timer browser: read-only, sorted by next activation.
# Journal browser: real-time streaming log with unit selector.

# ── Shared unit preview ────────────────────────────────────────────────────────
_SD_PREVIEW='SYSTEMD_COLORS=1 systemctl status --no-pager --lines=20 {} 2>/dev/null'

# ── Reload expression (used by start/stop/enable/disable/restart binds) ───────
_SD_RELOAD='systemctl list-units --all --no-legend --no-pager 2>/dev/null | awk "{print \$1}"'

# ── Services browser ──────────────────────────────────────────────────────────
_fzf_sd_services() {
  systemctl list-units --all --no-legend --no-pager 2>/dev/null \
  | awk '{print $1}' \
  | fzf \
      --multi \
      --prompt='systemd ❯ ' \
      --header=$'Ctrl+S: start  Ctrl+T: stop  Ctrl+E: enable  Ctrl+D: disable  Ctrl+R: restart  Ctrl+L: logs\nCtrl+/: preview  Enter: status in pager' \
      --preview="$_SD_PREVIEW" \
      --preview-window='right:60%:border-rounded:wrap' \
      --bind='ctrl-/:toggle-preview' \
      --bind='ctrl-y:execute-silent(echo -n {} | wl-copy 2>/dev/null)+bell' \
      --bind="ctrl-s:execute-silent(sudo systemctl start   {})+reload($_SD_RELOAD)+refresh-preview" \
      --bind="ctrl-t:execute-silent(sudo systemctl stop    {})+reload($_SD_RELOAD)+refresh-preview" \
      --bind="ctrl-e:execute-silent(sudo systemctl enable  {})+reload($_SD_RELOAD)+refresh-preview" \
      --bind="ctrl-d:execute-silent(sudo systemctl disable {})+reload($_SD_RELOAD)+refresh-preview" \
      --bind="ctrl-r:execute-silent(sudo systemctl restart {})+reload($_SD_RELOAD)+refresh-preview" \
      --bind='ctrl-l:execute(journalctl -fu {} </dev/tty >/dev/tty 2>&1)' \
      --bind='enter:execute(SYSTEMD_COLORS=1 systemctl status --no-pager {} 2>/dev/null | bat --style=plain --color=always --paging=always --language=log)' \
      --scheme=default
}

# ── Timer browser ─────────────────────────────────────────────────────────────
_fzf_sd_timers() {
  systemctl list-timers --all --no-pager 2>/dev/null \
  | grep -v '^$' \
  | fzf \
      --prompt='timers ❯ ' \
      --header='Read-only timer view. Enter: show unit status.' \
      --preview='
        # Last field before PASSED/LEFT is the unit name
        unit=$(echo {} | awk "{print \$NF}")
        SYSTEMD_COLORS=1 systemctl status --no-pager "$unit" 2>/dev/null
      ' \
      --preview-window='right:55%:border-rounded:wrap' \
      --bind='ctrl-/:toggle-preview' \
      --scheme=default
}

# ── Journal browser ───────────────────────────────────────────────────────────
_fzf_sd_journal() {
  local unit
  unit=$(
    systemctl list-units --all --no-legend --no-pager 2>/dev/null \
    | awk '{print $1}' \
    | fzf \
        --prompt='journal ❯ ' \
        --height=50% \
        --header='Select a unit to stream its logs (Ctrl+C to exit stream)' \
        --preview="$_SD_PREVIEW" \
        --preview-window='right:55%:border-rounded:wrap'
  )
  [[ -n $unit ]] && journalctl -fu "$unit" --output=short-precise
}

# ── Failed units ─────────────────────────────────────────────────────────────
_fzf_sd_failed() {
  local failed
  failed=$(systemctl list-units --failed --no-legend --no-pager 2>/dev/null)
  if [[ -z $failed ]]; then
    print -P '%F{green}✓ No failed units.%f'; return
  fi
  echo "$failed" \
  | awk '{print $1}' \
  | fzf \
      --prompt='failed ❯ ' \
      --header='Failed units. Ctrl+R: restart. Ctrl+L: logs.' \
      --preview="$_SD_PREVIEW" \
      --preview-window='right:60%:border-rounded:wrap' \
      --bind='ctrl-r:execute-silent(sudo systemctl restart {})+reload(systemctl list-units --failed --no-legend --no-pager | awk "{print \$1}")+refresh-preview' \
      --bind='ctrl-l:execute(journalctl -fu {} </dev/tty >/dev/tty)'
}

# ── Hub widget (Alt+S) ────────────────────────────────────────────────────────
_fzf_systemd_hub() {
  local -a ops=(
    'services — browse all units; start/stop/enable/disable/restart'
    'timers   — view systemd timers and next activation times'
    'journal  — live-stream logs for any unit'
    'failed   — show and recover failed units'
  )

  local choice
  choice=$(
    printf '%s\n' "${ops[@]}" \
    | fzf \
        --prompt='systemd ❯ ' \
        --height=35% \
        --min-height=8 \
        --layout=reverse \
        --border=rounded \
        --no-preview \
        --header='Systemd Hub'
  )
  [[ -z $choice ]] && { zle reset-prompt; return }

  case ${choice%%[[:space:]]*} in
    services) _fzf_sd_services ;;
    timers)   _fzf_sd_timers   ;;
    journal)  _fzf_sd_journal  ;;
    failed)   _fzf_sd_failed   ;;
  esac
  zle reset-prompt
}
zle -N _fzf_systemd_hub
bindkey -M emacs '^[s' _fzf_systemd_hub
bindkey -M viins '^[s' _fzf_systemd_hub
bindkey -M vicmd '^[s' _fzf_systemd_hub

unset _SD_PREVIEW _SD_RELOAD
