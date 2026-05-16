# widgets/systemd.zsh — systemd management hub. Alt+S.
#
# Service browser: Ctrl+S start  Ctrl+T stop  Ctrl+E enable  Ctrl+D disable
#                  Ctrl+R restart  Ctrl+L live logs  Enter full status in pager
# Subcommands: services / timers / journal / failed

# FIX: keep as typeset -g (not unset). These are referenced by value inside
# functions at call time. Unsetting them after definition leaves function bodies
# with empty strings for --preview and the eval'd reload command.
typeset -g _SD_PREVIEW='SYSTEMD_COLORS=1 systemctl status --no-pager --lines=20 {} 2>/dev/null'
typeset -g _SD_LIST='systemctl list-units --all --no-legend --no-pager 2>/dev/null | awk "{print \$1}"'

_fzf_sd_services() {
  eval "$_SD_LIST" \
  | fzf \
      --multi \
      --prompt='systemd ❯ ' \
      --input-label=' Units ' \
      --header='  Ctrl+S: start  Ctrl+T: stop  Ctrl+E: enable  Ctrl+D: disable  Ctrl+R: restart  Ctrl+L: logs' \
      --header-border=bottom \
      --bind="load:transform-footer:echo ' \$FZF_TOTAL_COUNT units'" \
      --footer-border=top \
      --preview="$_SD_PREVIEW" \
      --preview-window='right:60%:border-rounded:wrap' \
      --bind='ctrl-/:toggle-preview' \
      --bind='ctrl-y:execute-silent(echo -n {} | wl-copy 2>/dev/null)+bell' \
      --bind="ctrl-s:execute-silent(sudo systemctl start   {})+reload($_SD_LIST)+refresh-preview" \
      --bind="ctrl-t:execute-silent(sudo systemctl stop    {})+reload($_SD_LIST)+refresh-preview" \
      --bind="ctrl-e:execute-silent(sudo systemctl enable  {})+reload($_SD_LIST)+refresh-preview" \
      --bind="ctrl-d:execute-silent(sudo systemctl disable {})+reload($_SD_LIST)+refresh-preview" \
      --bind="ctrl-r:execute-silent(sudo systemctl restart {})+reload($_SD_LIST)+refresh-preview" \
      --bind='ctrl-l:execute(journalctl -fu {} </dev/tty >/dev/tty 2>&1)' \
      --bind='enter:execute(SYSTEMD_COLORS=1 systemctl status --no-pager {} 2>/dev/null | bat --style=plain --color=always --paging=always --language=log)' \
      --scheme=default
}

_fzf_sd_timers() {
  systemctl list-timers --all --no-pager 2>/dev/null \
  | grep -v '^$' \
  | fzf \
      --prompt='timers ❯ ' \
      --input-label=' Timers ' \
      --header='  Read-only. Enter: show unit status.' \
      --header-border=bottom \
      --preview='
        unit=$(echo {} | awk "{print \$NF}")
        SYSTEMD_COLORS=1 systemctl status --no-pager "$unit" 2>/dev/null
      ' \
      --preview-window='right:55%:border-rounded:wrap' \
      --bind='ctrl-/:toggle-preview' \
      --scheme=default
}

_fzf_sd_journal() {
  local unit
  unit=$(
    eval "$_SD_LIST" \
    | fzf \
        --prompt='journal ❯ ' \
        --input-label=' Select Unit ' \
        --height=50% \
        --header='  Select unit to stream logs (Ctrl+C to exit stream)' \
        --preview="$_SD_PREVIEW" \
        --preview-window='right:55%:border-rounded:wrap'
  )
  [[ -n $unit ]] && journalctl -fu "$unit" --output=short-precise
}

_fzf_sd_failed() {
  local failed
  failed=$(systemctl list-units --failed --no-legend --no-pager 2>/dev/null)
  if [[ -z $failed ]]; then
    zle -M '✓ No failed units.'
    zle reset-prompt
    return
  fi
  echo "$failed" \
  | awk '{print $1}' \
  | fzf \
      --prompt='failed ❯ ' \
      --input-label=' Failed Units ' \
      --header='  Ctrl+R: restart  Ctrl+L: logs  Ctrl+X: reset-failed' \
      --header-border=bottom \
      --preview="$_SD_PREVIEW" \
      --preview-window='right:60%:border-rounded:wrap' \
      --bind='ctrl-/:toggle-preview' \
      --bind='ctrl-r:execute-silent(sudo systemctl restart      {})+reload(systemctl list-units --failed --no-legend --no-pager | awk "{print \$1}")+refresh-preview' \
      --bind='ctrl-x:execute-silent(sudo systemctl reset-failed {})+reload(systemctl list-units --failed --no-legend --no-pager | awk "{print \$1}")+refresh-preview' \
      --bind='ctrl-l:execute(journalctl -fu {} </dev/tty >/dev/tty)'
}

_fzf_systemd_hub() {
  local choice
  choice=$(
    printf '%s\n' \
      'services  browse all units; start/stop/enable/disable/restart' \
      'timers    view systemd timers and next activation' \
      'journal   live-stream logs for any unit' \
      'failed    show and recover failed units' \
    | fzf \
        --prompt='systemd ❯ ' \
        --height=35% \
        --min-height=8 \
        --layout=reverse \
        --border=rounded \
        --no-preview \
        --header='  Systemd Hub'
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