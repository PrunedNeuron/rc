# $ZCONFDIR/widgets/fzf-man.zsh
#
# Fuzzy man page browser. Alt+I (Info/man).
# Lists all available man pages; previews first 60 lines via bat.
#
# Actions:
#   Enter       open in nvim with :Man (full navigation, links, search)
#   Ctrl+P      open in less (traditional pager)
#   Ctrl+Y      copy man page name to clipboard
#   Ctrl+/      toggle preview

_fzf_man_browser() {
  local selected
  selected=$(
    # man -k '' lists all man pages; format: name (section) - description
    man -k '' 2>/dev/null \
    | sort \
    | fzf \
        --prompt='man ❯ ' \
        --header='Enter: open in nvim  Ctrl+P: open in less  Ctrl+Y: copy name' \
        --preview='
          # Extract "name(section)" and convert to "section name" for man
          entry=$(echo {1} | sed "s/(\(.*\))/\1/")
          name=$(echo {1} | sed "s/(.*//")
          section=$(echo {1} | grep -oP "(?<=\()\w+(?=\))")
          man -P cat "$section" "$name" 2>/dev/null \
            | head -60 \
            | bat --language=man --style=plain --color=always 2>/dev/null \
            || man -P cat "$name" 2>/dev/null | head -60
        ' \
        --preview-window='right:55%:border-rounded:wrap' \
        --bind='ctrl-/:toggle-preview' \
        --bind='ctrl-y:execute-silent(echo -n {1} | wl-copy 2>/dev/null)+bell' \
        --bind='ctrl-p:execute(
          name=$(echo {1} | sed "s/(.*//")
          sec=$(echo {1} | grep -oP "(?<=\()\w+(?=\))")
          man "$sec" "$name" 2>/dev/null || man "$name"
        )'
  )

  [[ -z $selected ]] && { zle reset-prompt; return }

  local name sec
  name=$(echo "$selected" | sed 's/(.*//; s/ .*//')
  sec=$(echo "$selected" | grep -oP '(?<=\()\w+(?=\))')

  # Open in nvim with :Man plugin for full navigation
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
