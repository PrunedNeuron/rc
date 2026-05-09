# $ZCONFDIR/widgets/fzf-process.zsh — interactive process browser/killer. Alt+K.
#
# Default: all user processes sorted by %CPU.
# Actions:
#   Ctrl+Space  mark for batch op     Ctrl+A      mark all
#   Enter       SIGTERM (graceful)    Ctrl+K      SIGKILL (force)
#   Ctrl+R      SIGSTOP (pause)       Ctrl+C      SIGCONT (resume)
#   Ctrl+U      sort by CPU           Ctrl+M      sort by memory
#   Ctrl+/      toggle preview

_ps_all='ps aux --sort=-%cpu'

_fzf_process_hub() {
  eval "$_ps_all" \
  | tail -n +2 \
  | fzf \
      --multi \
      --prompt='process ❯ ' \
      --input-label=' Processes ' \
      --ansi \
      --header='  Enter: SIGTERM  Ctrl+K: SIGKILL  Ctrl+R: pause  Ctrl+C: resume  Ctrl+U: CPU  Ctrl+M: MEM' \
      --header-border=bottom \
      --bind="load:transform-footer:echo ' \$FZF_TOTAL_COUNT processes'" \
      --footer-border=top \
      --preview='
        pid=$(echo {} | awk "{print \$2}")
        echo "── Process ────────────────────────────────────────"
        ps -p "$pid" -o pid,ppid,user,pcpu,pmem,vsz,rss,tty,stat,stime,time,comm --no-headers 2>/dev/null
        echo
        echo "── Open Files (head 20) ───────────────────────────"
        lsof -p "$pid" 2>/dev/null | head -20
        echo
        echo "── Environment (head 10) ──────────────────────────"
        cat /proc/"$pid"/environ 2>/dev/null | tr "\0" "\n" | head -10
      ' \
      --preview-window='right:55%:border-rounded:wrap' \
      --bind='ctrl-/:toggle-preview' \
      --bind="ctrl-u:reload($_ --sort=-%cpu | tail -n +2)" \
      --bind="ctrl-m:reload($_ --sort=-%mem | tail -n +2)" \
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

  zle reset-prompt
}

zle -N _fzf_process_hub
bindkey -M emacs '^[k' _fzf_process_hub
bindkey -M viins '^[k' _fzf_process_hub
bindkey -M vicmd '^[k' _fzf_process_hub

unset _ps_all
