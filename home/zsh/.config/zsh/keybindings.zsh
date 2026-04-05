# $ZCONFDIR/keybindings.zsh — sourced last; these bindings are final.

bindkey -e  # emacs base keymap

# ── Terminal application mode ─────────────────────────────────────────────────
# Enables extended terminfo key sequences. Skipped on dumb/degraded terminals.
if (( ${+terminfo[smkx]} && ${+terminfo[rmkx]} )); then
  zle-line-init()   { echoti smkx }
  zle-line-finish() { echoti rmkx }
  zle -N zle-line-init
  zle -N zle-line-finish
fi

# ── Word boundary style ───────────────────────────────────────────────────────
# 'bash' stops word-kill at '/', '-', '.', '=' — matches GUI text field behaviour
autoload -Uz select-word-style
select-word-style bash

# ── Helpers ───────────────────────────────────────────────────────────────────
_bk()  { bindkey -M emacs "$1" "$2"; bindkey -M viins "$1" "$2"; bindkey -M vicmd "$1" "$2" }
_bti() { [[ -n ${terminfo[$1]} ]] && _bk "${terminfo[$1]}" "$2" }

# ── History navigation ────────────────────────────────────────────────────────
autoload -Uz up-line-or-beginning-search down-line-or-beginning-search
zle -N up-line-or-beginning-search
zle -N down-line-or-beginning-search

_bti kpp   up-line-or-history
_bti knp   down-line-or-history
_bti kcuu1 up-line-or-beginning-search
_bti kcud1 down-line-or-beginning-search

# Escape-sequence fallbacks (xterm, kitty, rxvt, tmux, …)
_bk '^[[A' up-line-or-beginning-search
_bk '^[OA' up-line-or-beginning-search
_bk '^[[B' down-line-or-beginning-search
_bk '^[OB' down-line-or-beginning-search

# ── Line navigation ───────────────────────────────────────────────────────────
_bti khome beginning-of-line
_bti kend  end-of-line
_bk '^[[H'  beginning-of-line   # xterm / kitty
_bk '^[[F'  end-of-line
_bk '^[[1~' beginning-of-line   # rxvt
_bk '^[[4~' end-of-line

# ── Character navigation ──────────────────────────────────────────────────────
# Bare arrows = one character. Ctrl/Alt+Arrow = one word.
_bk '^[[C' forward-char
_bk '^[[D' backward-char

_bk '^[[1;5C' forward-word      # Ctrl+Right
_bk '^[[1;5D' backward-word     # Ctrl+Left
_bk '^[[1;3C' forward-word      # Alt+Right
_bk '^[[1;3D' backward-word     # Alt+Left

# ── Deletion ─────────────────────────────────────────────────────────────────
_bk '^?' backward-delete-char   # Backspace (0x7F)
_bti kdch1  delete-char
_bk '^[[3~' delete-char         # Delete fallback

_bk '^[[3;5~' kill-word         # Ctrl+Delete
_bk '^[[3;5M' kill-word         # Ctrl+Delete (kitty keyboard protocol)

# Ctrl+Backspace: ^H (0x08) is the universal encoding.
# Kitty "full keyboard protocol" sends ^[[127;5u instead.
# select-word-style bash (above) ensures stop at '/', '-', '.', etc.
_bk '^H'        backward-kill-word
_bk '^[[127;5u' backward-kill-word

# Alt+Backspace
_bk '^[^?' backward-kill-word
_bk '^[^H' backward-kill-word

# ── Completion ────────────────────────────────────────────────────────────────
_bti kcbt reverse-menu-complete
_bk '^[[Z' reverse-menu-complete

# ── Editing utilities ─────────────────────────────────────────────────────────
bindkey ' '    magic-space
bindkey '^r'   history-incremental-search-backward  # atuin overrides this async
bindkey '^_'   undo
bindkey '^[^_' redo
bindkey '^u'   kill-whole-line
bindkey '^[.'  insert-last-word
bindkey '\ew'  kill-region
bindkey -s '\el' 'ls\n'

# ── Bracketed paste ───────────────────────────────────────────────────────────
autoload -Uz bracketed-paste-magic
zle -N bracketed-paste bracketed-paste-magic

# ── zsh-history-substring-search ─────────────────────────────────────────────
# Override the Up/Down bindings set above only if the plugin actually loaded.
(( ${+functions[history-substring-search-up]} )) && {
  bindkey '^[[A' history-substring-search-up
  bindkey '^[OA' history-substring-search-up
  bindkey '^[[B' history-substring-search-down
  bindkey '^[OB' history-substring-search-down
}

# ── Custom widgets ────────────────────────────────────────────────────────────
# ~*.zwc excludes compiled binary files from being sourced as shell
for _f in $ZCONFDIR/widgets/**/^*.zwc(.N); do builtin source "$_f"; done; unset _f

unfunction _bk _bti
