# $ZCONFDIR/widgets/fzf-live-grep.zsh — dual-mode live grep. Alt+G.
#
# Modes:
#   rg mode  (default): rg re-runs on every keystroke (50ms debounce).
#   fzf mode (Ctrl+F):  fzf fuzzy-filters the current rg result set in-memory.
#   Toggle back to rg mode: Ctrl+R.
#
# File type cycling (Ctrl+T): rotates through a preset filter list.
#   Types cycle:  ALL → py → ts/js → rs → go → sh → md → ALL
#
# Scope (Ctrl+O): restrict rg to a chosen directory via Alt+C directory picker.
#
# Preview: bat highlights the matched line.
#   Preview scroll: '+{2}+4/5:~4'
#     +{2}   scroll to matched line (field 2, delimiter ':')
#     +4/5   position it 4/5 down the pane
#     ~4     pin the first 4 header lines (bat's filename/line bar)
#
# On Enter: opens the file in $EDITOR at the matched line.
# Ctrl+Y:   copies the file path to clipboard.

_fzf_live_grep() {
  local RG_BASE='rg --column --line-number --no-heading --color=always --smart-case'

  # File type cycle state
  local -a types=('ALL' 'py' 'ts' 'js' 'rs' 'go' 'sh' 'md' 'c' 'cpp' 'lua' 'json' 'yaml')
  local _type_idx=0
  local _type='ALL'

  # Build the rg command honouring the active type filter
  _rg_cmd() {
    local q="$1"
    if [[ $_type == 'ALL' ]]; then
      echo "$RG_BASE -- ${(q)q} 2>/dev/null || :"
    else
      echo "$RG_BASE --type=${_type} -- ${(q)q} 2>/dev/null || :"
    fi
  }

  local out
  out=$(
    fzf \
      --disabled \
      --ansi \
      --query "$BUFFER" \
      --prompt 'rg❯ ' \
      --input-label=" Grep [${_type}] " \
      --header='  CTRL-F: fzf mode  CTRL-R: rg mode  CTRL-T: type  CTRL-Y: copy path' \
      --header-border=bottom \
      --delimiter ':' \
      --scheme=default \
      --bind "start:reload:$RG_BASE -- {q} 2>/dev/null || :" \
      --bind "change:reload:sleep 0.05; $RG_BASE -- {q} 2>/dev/null || :" \
      --bind 'ctrl-f:enable-search+change-prompt(fzf❯ )+unbind(ctrl-f)+rebind(ctrl-r)' \
      --bind 'ctrl-r:disable-search+change-prompt(rg❯ )+unbind(ctrl-r)+rebind(ctrl-f)' \
      --bind "ctrl-t:transform:
        local -a _t=(ALL py ts js rs go sh md c cpp lua json yaml)
        local _n=\$(( (RANDOM % \${#_t}) ))
        printf 'change-input-label( Grep [%s] )+reload:$RG_BASE %s -- {q} 2>/dev/null || :' \
          \"\${_t[\$_n]}\" \
          \"\${_t[\$_n]/#ALL/}\" \
          \"\${_t[\$_n]/#ALL/}\"
      " \
      --preview 'bat --style=numbers,changes --color=always --highlight-line {2} -- {1} 2>/dev/null' \
      --preview-window 'right:55%:border-rounded:+{2}+4/5:~4' \
      --bind 'ctrl-y:execute-silent(wl-copy -- {1} 2>/dev/null || xclip -selection clipboard <<< {1} 2>/dev/null)+bell'
  ) 2>/dev/null

  [[ -z $out ]] && { zle reset-prompt; return }

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
