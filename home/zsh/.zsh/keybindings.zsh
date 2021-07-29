# Keybindings

# Cursor type
echo -ne "\e]50;CursorShape=2\a" # Underline
#echo -ne "\e]50;CursorShape=1\a" # Line
#echo -ne "\e]50;CursorShape=1\a" # Block

bindkey '^[[A' history-substring-search-up
bindkey '^[[B' history-substring-search-down
bindkey '^[[3~' delete-char
bindkey '^[3;5~' delete-char

# Home/End keys
bindkey '\e[1~'   beginning-of-line  # Linux console
bindkey '\e[H'    beginning-of-line  # xterm
bindkey '\eOH'    beginning-of-line  # gnome-terminal
bindkey '\e[2~'   overwrite-mode     # Linux console, xterm, gnome-terminal
bindkey '\e[3~'   delete-char        # Linux console, xterm, gnome-terminal
bindkey '\e[4~'   end-of-line        # Linux console
bindkey '\e[F'    end-of-line        # xterm
bindkey '\eOF'    end-of-line        # gnome-terminal

# Crtl+Left, Crlt+Right
bindkey '^[[1;5D' backward-word
bindkey '^[[1;5C' forward-word

# Crtl+Backspace, Crtl+Delete
bindkey '^[[3;5~' kill-word
bindkey '^[[3^' kill-word
bindkey '^H' backward-kill-word # doesn't work anymore for some reason
bindkey '\b' backward-kill-word

# [Ctrl-Backspace] - delete whole backward-word
bindkey -M emacs '^H' backward-kill-word
bindkey -M viins '^H' backward-kill-word
bindkey -M vicmd '^H' backward-kill-word

# [Ctrl-Delete] - delete whole forward-word
bindkey -M emacs '^[[3;5~' kill-word
bindkey -M viins '^[[3;5~' kill-word
bindkey -M vicmd '^[[3;5~' kill-word



### Program specific

# fzf
bindkey '^T' fzf-completion
# bindkey '^I' $fzf_default_completion # breaks fzf tab completion
zle     -N     fzf-history-widget-accept
bindkey '^X^R' fzf-history-widget-accept



### Misc / Non-essential

# File manager key binds
# Alt+Left = go back
# Alt+Up = go to parent dir
cdUndoKey() {
  popd
  zle reset-prompt
  print
  ls
  zle reset-prompt
}

cdParentKey() {
  pushd ..
  zle reset-prompt
  print
  ls
  zle reset-prompt
}

zle -N cdParentKey
zle -N cdUndoKey
bindkey '^[[1;3A' cdParentKey
bindkey '^[[1;3D' cdUndoKey

# Exit zsh even on partial command line
exit_zsh() { exit }
zle -N exit_zsh
bindkey '^D' exit_zsh


# fzf specific
fzf-history-widget-accept() {
  fzf-history-widget
  zle accept-line
}


