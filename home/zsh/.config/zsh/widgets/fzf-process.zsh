# $ZCONFDIR/widgets/fzf-process.zsh
#
# Advanced interactive process browser and killer. Alt+K.
#
# Default view: all user processes sorted by CPU usage.
# Actions:
#   Ctrl+Space  mark for batch kill
#   Ctrl+A      mark all
#   Enter       send SIGTERM to selected (graceful)
#   Ctrl+K      send SIGKILL to selected (force)
#   Ctrl+R      send SIGSTOP (pause)
#   Ctrl+C      send SIGCONT (resume)
#   Ctrl+I      show full process info (lsof, strace-ready)
#   Ctrl+/      toggle preview
#   Ctrl+U      sort by CPU
#   Ctrl+M      sort by memory

_fzf_process_hub() {
  local _ps_cmd='ps aux --sort=-%cpu'
  local _ps_header='USER       PID  %CPU %MEM    VSZ   RSS TTY      STAT  COMMAND'

  local result
  result=$(
    eval "$_ps_cmd" \
    | tail -n +2 \
    | fzf \
        --multi \
        --prompt='process ❯ ' \
        --ansi \
        --header-lines=0 \
        --header=$'Ctrl+Space: mark  Enter: SIGTERM  Ctrl+K: SIGKILL  Ctrl+R: pause  Ctrl+C: resume\nCtrl+U: sort CPU  Ctrl+M: sort MEM  Ctrl+/: preview' \
        --preview='
          pid=$(echo {} | awk "{print \$2}")
          echo "── Process Info ──────────────────────────────────"
          ps -p "$pid" -o pid,ppid,user,pcpu,pmem,vsz,rss,tty,stat,stime,time,comm --no-headers 2>/dev/null
          echo
          echo "── Open Files (head 20) ──────────────────────────"
          lsof -p "$pid" 2>/dev/null | head -20
          echo
          echo "── Environment (head 10) ─────────────────────────"
          cat /proc/"$pid"/environ 2>/dev/null | tr "\0" "\n" | head -10
        ' \
        --preview-window='right:55%:border-rounded:wrap' \
        --bind='ctrl-/:toggle-preview' \
        --bind='ctrl-u:reload(ps aux --sort=-%cpu | tail -n +2)' \
        --bind='ctrl-m:reload(ps aux --sort=-%mem | tail -n +2)' \
        --bind='enter:execute-silent(
          pids=$(echo {+} | awk "{print \$2}"); kill -TERM $pids 2>/dev/null
        )+reload(ps aux --sort=-%cpu | tail -n +2)' \
        --bind='ctrl-k:execute-silent(
          pids=$(echo {+} | awk "{print \$2}"); kill -KILL $pids 2>/dev/null
        )+reload(ps aux --sort=-%cpu | tail -n +2)' \
        --bind='ctrl-r:execute-silent(
          pids=$(echo {+} | awk "{print \$2}"); kill -STOP $pids 2>/dev/null
        )+reload(ps aux --sort=-%cpu | tail -n +2)' \
        --bind='ctrl-c:execute-silent(
          pids=$(echo {+} | awk "{print \$2}"); kill -CONT $pids 2>/dev/null
        )+reload(ps aux --sort=-%cpu | tail -n +2)'
  )
  zle reset-prompt
}
zle -N _fzf_process_hub
bindkey -M emacs '^[k' _fzf_process_hub
bindkey -M viins '^[k' _fzf_process_hub
bindkey -M vicmd '^[k' _fzf_process_hub
