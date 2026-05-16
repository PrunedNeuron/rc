# widgets/process.zsh — Interactive process browser/killer. Alt+K.
#
# Ctrl+Space  mark for batch op     Ctrl+A   mark all
# Enter       SIGTERM (graceful)    Ctrl+K   SIGKILL (force)
# Ctrl+R      SIGSTOP (pause)       Ctrl+C   SIGCONT (resume)
# Ctrl+U      sort by %CPU          Ctrl+M   sort by %MEM
# Ctrl+/      toggle preview

_fzf_process_hub() {
  # FIX: the original used $_ inside bind strings to reference the ps command.
  # $_ is the last argument of the previous simple command and is unreliable in
  # this context. Reference the ps invocation directly in every reload string.
  ps aux --sort=-%cpu \
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
        ps -p "$pid" -o pid,ppid,user,pcpu,pmem,vsz,rss,tty,stat,stime,time,comm \
           --no-headers 2>/dev/null
        echo
        echo "── Open Files (head 20) ───────────────────────────"
        lsof -p "$pid" 2>/dev/null | head -20
        echo
        echo "── Environment (head 10) ──────────────────────────"
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

  zle reset-prompt
}

zle -N _fzf_process_hub
bindkey -M emacs '^[k' _fzf_process_hub
bindkey -M viins '^[k' _fzf_process_hub
bindkey -M vicmd '^[k' _fzf_process_hub