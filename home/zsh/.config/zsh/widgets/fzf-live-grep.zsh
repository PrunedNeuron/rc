# $ZCONFDIR/widgets/fzf-live-grep.zsh
# Interactive live grep: rg drives the search engine, fzf selects the result,
# $EDITOR opens at the exact line. Bound to Alt+G in all keymaps.
#
# Requires: rg (ripgrep), fzf ≥ 0.59, bat, delta (optional).
#
# Search modes (toggled inside fzf with the header-displayed bindings):
#
#   rg mode  (default) — fzf --disabled; every keystroke re-invokes rg.
#            rg's SIMD-parallelised engine handles filtering; fzf is a pure
#            selector. Use this when you know what you're grepping for.
#
#   fzf mode (ctrl-r)  — fzf re-enables its fuzzy engine over the *current*
#            rg result set without rerunning rg. Use this to narrow a large
#            result set without waiting for another filesystem scan.
#
# Preview window scroll expression '+{2}+4/5:~4':
#   +{2}   — scroll to the matched line number (field 2, delimiter ':')
#   +4/5   — position that line 4/5 of the way down the preview pane
#   ~4     — keep the first 4 lines (file header from bat) always visible

_fzf_live_grep() {
  local RG_CMD='rg --column --line-number --no-heading --color=always --smart-case --'

  local out
  out=$(
    fzf \
      --disabled \
      --ansi \
      --query "$BUFFER" \
      --bind "start:reload:$RG_CMD {q} || :" \
      --bind "change:reload:$RG_CMD {q} || :" \
      --bind 'ctrl-r:enable-search+change-prompt(fzf❯ )+unbind(ctrl-r)+rebind(ctrl-f)' \
      --bind 'ctrl-f:disable-search+change-prompt(rg❯ )+unbind(ctrl-f)+rebind(ctrl-r)' \
      --prompt 'rg❯ ' \
      --delimiter ':' \
      --header 'alt-g: live-grep  ctrl-f: fzf mode  ctrl-r: rg mode  ctrl-y: copy path' \
      --preview 'bat --style=numbers,changes --color=always --highlight-line {2} -- {1} 2>/dev/null' \
      --preview-window 'right:55%:border-rounded:+{2}+4/5:~4' \
      --bind 'ctrl-y:execute-silent(wl-copy -- {1} 2>/dev/null || xclip -selection clipboard <<< {1} 2>/dev/null)+bell'
  ) 2>/dev/null

  # On Esc or empty selection, reset prompt without modifying the buffer.
  if [[ -z $out ]]; then
    zle reset-prompt
    return
  fi

  local file line
  file=$(cut -d: -f1 <<< "$out")
  line=$(cut -d: -f2 <<< "$out")
  [[ -n $file ]] && ${EDITOR:-nvim} -- "$file" "+$line"
  zle reset-prompt
}

zle -N _fzf_live_grep

# Bind Alt+G in all three keymaps.
# _bk is cleaned up before widgets/ are sourced, so bind directly.
bindkey -M emacs '^[g' _fzf_live_grep
bindkey -M viins '^[g' _fzf_live_grep
bindkey -M vicmd '^[g' _fzf_live_grep
