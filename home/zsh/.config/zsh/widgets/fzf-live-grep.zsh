# $ZCONFDIR/widgets/fzf-live-grep.zsh
#
# Dual-mode interactive live grep. Alt+G.
# rg mode (default): fzf as selector, rg re-runs per keystroke (50ms debounce).
# fzf mode (Ctrl+F): fzf fuzzy-filters the current rg result set without rg re-runs.
#
# Preview scroll: '+{2}+4/5:~4'
#   +{2}   scroll to the matched line (field 2, delimiter ':')
#   +4/5   position that line 4/5 down the pane
#   ~4     pin the first 4 header lines (bat's filename/line bar)

_fzf_live_grep() {
  local RG='rg --column --line-number --no-heading --color=always --smart-case --'

  local out
  out=$(
    fzf \
      --disabled \
      --ansi \
      --query "$BUFFER" \
      --bind "start:reload:$RG {q} || :" \
      --bind "change:reload:sleep 0.05; $RG {q} || :" \
      --bind 'ctrl-f:enable-search+change-prompt(fzf❯ )+unbind(ctrl-f)+rebind(ctrl-r)' \
      --bind 'ctrl-r:disable-search+change-prompt(rg❯ )+unbind(ctrl-r)+rebind(ctrl-f)' \
      --prompt 'rg❯ ' \
      --delimiter ':' \
      --scheme=default \
      --header $'ALT-G: live grep  CTRL-F: fzf filter  CTRL-R: rg mode  CTRL-Y: copy path' \
      --preview 'bat --style=numbers,changes --color=always --highlight-line {2} -- {1} 2>/dev/null' \
      --preview-window 'right:55%:border-rounded:+{2}+4/5:~4' \
      --bind 'ctrl-y:execute-silent(wl-copy -- {1} 2>/dev/null || xclip -selection clipboard <<< {1} 2>/dev/null)+bell'
  ) 2>/dev/null

  if [[ -z $out ]]; then
    zle reset-prompt; return
  fi

  local file="${out%%:*}"
  local rest="${out#*:}"
  local line="${rest%%:*}"
  [[ -n $file ]] && ${EDITOR:-nvim} -- "$file" "+$line"
  zle reset-prompt
}
zle -N _fzf_live_grep
bindkey -M emacs '^[g' _fzf_live_grep
bindkey -M viins '^[g' _fzf_live_grep
bindkey -M vicmd '^[g' _fzf_live_grep
