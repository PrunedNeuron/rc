# widgets/grep.zsh — Dual-mode live grep. Alt+G.
#
# rg mode  (default): rg re-runs on every keystroke with a 50ms debounce.
# fzf mode (Ctrl+F):  fzf fuzzy-filters the current result set in memory.
# Back to rg mode:    Ctrl+R.
#
# Enter: open matched file in $EDITOR at the matched line.
# Ctrl+Y: copy file path to clipboard.
#
# NOTE: The original type-cycling feature (Ctrl+T rotating through file type
# filters) was removed. It used zsh-specific array syntax inside fzf's
# transform action, which fzf evaluates with /bin/sh — making it silently
# broken. A clean reimplementation would require a state file and POSIX sh
# arithmetic; the fzf rg/fzf mode toggle already covers the main use case.

_fzf_live_grep() {
  local RG_BASE='rg --column --line-number --no-heading --color=always --smart-case'

  local out
  out=$(
    fzf \
      --disabled \
      --ansi \
      --query "$BUFFER" \
      --prompt='rg ❯ ' \
      --input-label=' Grep ' \
      --header='  Ctrl+F: fzf mode  Ctrl+R: rg mode  Ctrl+/: preview  Ctrl+Y: copy path' \
      --header-border=bottom \
      --delimiter=':' \
      --scheme=default \
      --bind "start:reload:$RG_BASE -- {q} 2>/dev/null || :" \
      --bind "change:reload:sleep 0.05; $RG_BASE -- {q} 2>/dev/null || :" \
      --bind 'ctrl-f:enable-search+change-prompt(fzf ❯ )+unbind(ctrl-f)+rebind(ctrl-r)' \
      --bind 'ctrl-r:disable-search+change-prompt(rg ❯ )+unbind(ctrl-r)+rebind(ctrl-f)' \
      --preview 'bat --style=numbers,changes --color=always --highlight-line {2} -- {1} 2>/dev/null' \
      --preview-window='right:55%:border-rounded:+{2}+4/5:~4' \
      --bind='ctrl-/:toggle-preview' \
      --bind='ctrl-y:execute-silent(wl-copy -- {1} 2>/dev/null || xclip -selection clipboard <<< {1} 2>/dev/null)+bell'
  ) 2>/dev/null

  [[ -z $out ]] && { zle reset-prompt; return }

  local file="${out%%:*}"
  local line="${${out#*:}%%:*}"
  [[ -n $file ]] && ${EDITOR:-nvim} -- "$file" "+${line:-1}"
  zle reset-prompt
}

zle -N _fzf_live_grep
bindkey -M emacs '^[g' _fzf_live_grep
bindkey -M viins '^[g' _fzf_live_grep
bindkey -M vicmd '^[g' _fzf_live_grep