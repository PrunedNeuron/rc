# Keybindings

# Make sure that the terminal is in application mode when zle is active, since
# only then values from $terminfo are valid
if (( ${+terminfo[smkx]} )) && (( ${+terminfo[rmkx]} )); then
  function zle-line-init() {
    echoti smkx
  }
  function zle-line-finish() {
    echoti rmkx
  }
  zle -N zle-line-init
  zle -N zle-line-finish
fi

# Use emacs key bindings
bindkey -e

# [PageUp] - Up a line of history
if [[ -n "${terminfo[kpp]}" ]]; then
  bindkey -M emacs "${terminfo[kpp]}" up-line-or-history
  bindkey -M viins "${terminfo[kpp]}" up-line-or-history
  bindkey -M vicmd "${terminfo[kpp]}" up-line-or-history
fi
# [PageDown] - Down a line of history
if [[ -n "${terminfo[knp]}" ]]; then
  bindkey -M emacs "${terminfo[knp]}" down-line-or-history
  bindkey -M viins "${terminfo[knp]}" down-line-or-history
  bindkey -M vicmd "${terminfo[knp]}" down-line-or-history
fi

# Start typing + [Up-Arrow] - fuzzy find history forward
if [[ -n "${terminfo[kcuu1]}" ]]; then
  autoload -U up-line-or-beginning-search
  zle -N up-line-or-beginning-search

  bindkey -M emacs "${terminfo[kcuu1]}" up-line-or-beginning-search
  bindkey -M viins "${terminfo[kcuu1]}" up-line-or-beginning-search
  bindkey -M vicmd "${terminfo[kcuu1]}" up-line-or-beginning-search

  bindkey '^[[A' up-line-or-beginning-search
  bindkey '^[OA' up-line-or-beginning-search

fi
# Start typing + [Down-Arrow] - fuzzy find history backward
if [[ -n "${terminfo[kcud1]}" ]]; then
  autoload -U down-line-or-beginning-search
  zle -N down-line-or-beginning-search

  bindkey -M emacs "${terminfo[kcud1]}" down-line-or-beginning-search
  bindkey -M viins "${terminfo[kcud1]}" down-line-or-beginning-search
  bindkey -M vicmd "${terminfo[kcud1]}" down-line-or-beginning-search

  bindkey '^[[B'  down-line-or-beginning-search
  bindkey '^[OB'  down-line-or-beginning-search

fi

# [Home] - Go to beginning of line
if [[ -n "${terminfo[khome]}" ]]; then
  bindkey -M emacs "${terminfo[khome]}" beginning-of-line
  bindkey -M viins "${terminfo[khome]}" beginning-of-line
  bindkey -M vicmd "${terminfo[khome]}" beginning-of-line
fi
# [End] - Go to end of line
if [[ -n "${terminfo[kend]}" ]]; then
  bindkey -M emacs "${terminfo[kend]}"  end-of-line
  bindkey -M viins "${terminfo[kend]}"  end-of-line
  bindkey -M vicmd "${terminfo[kend]}"  end-of-line
fi

# [Shift-Tab] - move through the completion menu backwards
if [[ -n "${terminfo[kcbt]}" ]]; then
  bindkey -M emacs "${terminfo[kcbt]}" reverse-menu-complete
  bindkey -M viins "${terminfo[kcbt]}" reverse-menu-complete
  bindkey -M vicmd "${terminfo[kcbt]}" reverse-menu-complete
fi

# [Backspace] - delete backward
bindkey -M emacs '^?' backward-delete-char
bindkey -M viins '^?' backward-delete-char
bindkey -M vicmd '^?' backward-delete-char
# [Delete] - delete forward
if [[ -n "${terminfo[kdch1]}" ]]; then
  bindkey -M emacs "${terminfo[kdch1]}" delete-char
  bindkey -M viins "${terminfo[kdch1]}" delete-char
  bindkey -M vicmd "${terminfo[kdch1]}" delete-char
else
  bindkey -M emacs "^[[3~" delete-char
  bindkey -M viins "^[[3~" delete-char
  bindkey -M vicmd "^[[3~" delete-char
fi

# [Ctrl-Delete] - delete whole forward-word
bindkey -M emacs '^[[3;5~' kill-word
bindkey -M viins '^[[3;5~' kill-word
bindkey -M vicmd '^[[3;5~' kill-word

# [Ctrl-Backspace] - kill the word backward
bindkey -M emacs '^H' backward-kill-word
bindkey -M viins '^H' backward-kill-word
bindkey -M vicmd '^H' backward-kill-word


# [Ctrl-RightArrow] - move forward one word
bindkey -M emacs '^[[1;5C' forward-word
bindkey -M viins '^[[1;5C' forward-word
bindkey -M vicmd '^[[1;5C' forward-word
# [Ctrl-LeftArrow] - move backward one word
bindkey -M emacs '^[[1;5D' backward-word
bindkey -M viins '^[[1;5D' backward-word
bindkey -M vicmd '^[[1;5D' backward-word


bindkey '\ew' kill-region                             # [Esc-w] - Kill from the cursor to the mark
bindkey -s '\el' 'ls\n'                               # [Esc-l] - run command: ls
bindkey '^r' history-incremental-search-backward      # [Ctrl-r] - Search backward incrementally for a specified string. The string may begin with ^ to anchor the search to the beginning of the line.
bindkey ' ' magic-space                               # [Space] - don't do history expansion

# Other
bindkey "^[[D" backward-word
bindkey "^[[C" forward-word
bindkey "^H" backward-kill-word



#
# create a zkbd compatible hash;
# to add other keys to this hash, see: man 5 terminfo
# typeset -g -A key
#
# key[Home]="${terminfo[khome]}"
# key[End]="${terminfo[kend]}"
# key[Insert]="${terminfo[kich1]}"
# key[Backspace]="${terminfo[kbs]}"
# key[Delete]="${terminfo[kdch1]}"
# key[Up]="${terminfo[kcuu1]}"
# key[Down]="${terminfo[kcud1]}"
# key[Left]="${terminfo[kcub1]}"
# key[Right]="${terminfo[kcuf1]}"
# key[PageUp]="${terminfo[kpp]}"
# key[PageDown]="${terminfo[knp]}"
# key[Shift-Tab]="${terminfo[kcbt]}"
#
# setup key accordingly
# [[ -n "${key[Home]}"      ]] && bindkey -- "${key[Home]}"       beginning-of-line
# [[ -n "${key[End]}"       ]] && bindkey -- "${key[End]}"        end-of-line
# [[ -n "${key[Insert]}"    ]] && bindkey -- "${key[Insert]}"     overwrite-mode
# [[ -n "${key[Backspace]}" ]] && bindkey -- "${key[Backspace]}"  backward-delete-char
# [[ -n "${key[Delete]}"    ]] && bindkey -- "${key[Delete]}"     delete-char
# [[ -n "${key[Up]}"        ]] && bindkey -- "${key[Up]}"         up-line-or-history
# [[ -n "${key[Up]}"        ]] && bindkey -- "${key[Up]}"         history-substring-search-up
# [[ -n "${key[Down]}"      ]] && bindkey -- "${key[Down]}"       down-line-or-history
# [[ -n "${key[Down]}"      ]] && bindkey -- "${key[Down]}"       history-substring-search-down
# [[ -n "${key[Left]}"      ]] && bindkey -- "${key[Left]}"       backward-char
# [[ -n "${key[Right]}"     ]] && bindkey -- "${key[Right]}"      forward-char
# [[ -n "${key[PageUp]}"    ]] && bindkey -- "${key[PageUp]}"     beginning-of-buffer-or-history
# [[ -n "${key[PageDown]}"  ]] && bindkey -- "${key[PageDown]}"   end-of-buffer-or-history
# [[ -n "${key[Shift-Tab]}" ]] && bindkey -- "${key[Shift-Tab]}"  reverse-menu-complete
#
# Finally, make sure the terminal is in application mode, when zle is
# active. Only then are the values from $terminfo valid.
# if (( ${+terminfo[smkx]} && ${+terminfo[rmkx]} )); then
# 	autoload -Uz add-zle-hook-widget
# 	function zle_application_mode_start { echoti smkx }
# 	function zle_application_mode_stop { echoti rmkx }
# 	add-zle-hook-widget -Uz zle-line-init zle_application_mode_start
# 	add-zle-hook-widget -Uz zle-line-finish zle_application_mode_stop
# fi
#
# autoload -Uz up-line-or-beginning-search down-line-or-beginning-search
# zle -N up-line-or-beginning-search
# zle -N down-line-or-beginning-search
#
# [[ -n "${key[Up]}"   ]] && bindkey -- "${key[Up]}"   up-line-or-beginning-search
# [[ -n "${key[Down]}" ]] && bindkey -- "${key[Down]}" down-line-or-beginning-search
#
# Cursor type
# echo -ne "\e]50;CursorShape=2\a" # Underline
#
# bindkey "^Q" push-line-or-edit
# bindkey "^N" insert-last-word
# bindkey "^Y" accept-and-hold
#
# History nav vertical
# bindkey '^[[A' history-substring-search-up
# bindkey '^[[B' history-substring-search-down
#
# Delete char
# bindkey '^[[3~' delete-char
#
# Ctrl+Left, Ctrl+Right
# bindkey '^[[1;5D' backward-word
# bindkey '^[[1;5C' forward-word
#
# Ctrl+Backspace, Ctrl+Delete
# bindkey '^[[3;5~' kill-word
# bindkey '^H' backward-kill-word # doesn't work anymore for some reason
#
# Movement
# bindkey '^A' beginning-of-line
# bindkey '^E' end-of-line
# bindkey "^K" kill-line
#
# Program specific
# fzf
# bindkey '^T' fzf-completion
# zle     -N     fzf-history-widget-accept
# bindkey '^X^R' fzf-history-widget-accept
#
# marlonrichert/zsh-autocomplete
# Up arrow:
# bindkey '\e[A' up-line-or-search
# bindkey '\eOA' up-line-or-search
# up-line-or-search:  Open history menu.
# up-line-or-history: Cycle to previous history line.
#
# Down arrow:
# bindkey '\e[B' down-line-or-select
# bindkey '\eOB' down-line-or-select
# down-line-or-select:  Open completion menu.
# down-line-or-history: Cycle to next history line.
#
# Control-Space:
# bindkey '\0' list-expand
# list-expand:      Reveal hidden completions.
# set-mark-command: Activate text selection.
#
# Misc / Non-essential
# Load widgets with their keybindings
source <(cat $(ls -1 $ZCONFDIR/widgets/**/*))
