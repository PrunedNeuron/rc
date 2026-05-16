# widgets/man.zsh — Fuzzy man page browser. Alt+I.
#
# Enter    open in nvim with :Man (full navigation + search)
# Ctrl+P   open in $PAGER (traditional)
# Ctrl+T   open tldr page (requires tealdeer or tldr)
# Ctrl+Y   copy name to clipboard
# Ctrl+/   toggle preview

_fzf_man_browser() {
  local selected
  selected=$(
    man -k '' 2>/dev/null \
    | sort \
    | fzf \
        --prompt='man ❯ ' \
        --input-label=' Man Pages ' \
        --header='  Enter: nvim  Ctrl+P: pager  Ctrl+T: tldr  Ctrl+Y: copy' \
        --header-border=bottom \
        --bind="load:transform-footer:echo ' \$FZF_TOTAL_COUNT pages'" \
        --footer-border=top \
        --preview='
          name=$(echo {1} | sed "s/(.*//; s/ .*//" )
          sec=$(echo  {1} | grep -oP "(?<=\()\w+(?=\))")
          man -P cat "$sec" "$name" 2>/dev/null \
            | head -80 \
            | bat --language=man --style=plain --color=always 2>/dev/null \
          || man -P cat "$name" 2>/dev/null | head -80
        ' \
        --preview-window='right:55%:border-rounded:wrap' \
        --bind='ctrl-/:toggle-preview' \
        --bind='ctrl-y:execute-silent(echo -n {1} | wl-copy 2>/dev/null)+bell' \
        --bind='ctrl-p:execute(
          name=$(echo {1} | sed "s/(.*//; s/ .*//" )
          sec=$(echo  {1} | grep -oP "(?<=\()\w+(?=\))")
          man "$sec" "$name" 2>/dev/null || man "$name"
        )' \
        --bind='ctrl-t:execute(
          name=$(echo {1} | sed "s/(.*//; s/ .*//" )
          tldr "$name" 2>/dev/null \
            | bat --style=plain --color=always --language=markdown 2>/dev/null \
          || tealdeer "$name" 2>/dev/null \
          || echo "tldr/tealdeer not installed (yay -S tealdeer)"
        )'
  )

  [[ -z $selected ]] && { zle reset-prompt; return }

  local name sec
  name=$(echo "$selected" | sed 's/(.*//; s/ .*//')
  sec=$(echo  "$selected" | grep -oP '(?<=\()\w+(?=\))')

  if command -v nvim &>/dev/null; then
    nvim -c "Man $sec $name" -c 'silent! only'
  else
    man "$sec" "$name" 2>/dev/null || man "$name"
  fi
  zle reset-prompt
}

zle -N _fzf_man_browser
bindkey -M emacs '^[i' _fzf_man_browser
bindkey -M viins '^[i' _fzf_man_browser
bindkey -M vicmd '^[i' _fzf_man_browser