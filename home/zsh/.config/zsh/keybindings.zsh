# $ZCONFDIR/keybindings.zsh — all key bindings. Always sourced last.

# ── fzf widget map ────────────────────────────────────────────────────────────
# Ctrl+T      file picker (multi-select, bat preview)
# Ctrl+R      history (atuin / fzf fallback)
# Alt+C       directory jump (zoxide + fzf)
# Alt+G       live ripgrep (dual rg/fzf mode)      [widgets/fzf-live-grep.zsh]
# Alt+M       package manager hub (pai/par/pao/pls) [widgets/fzf-pacman.zsh]
# Alt+S       systemd hub (services/timers/journal) [widgets/fzf-systemd.zsh]
# Alt+K       process browser/killer                [widgets/fzf-process.zsh]
# Alt+N       SSH/network host picker               [widgets/fzf-ssh.zsh]
# Alt+E       environment variable browser          [widgets/fzf-env.zsh]
# Alt+I       man page browser (opens in nvim)      [widgets/fzf-man.zsh]
# Alt+O       Docker hub (containers/images/vols)   [widgets/fzf-docker.zsh]
# Ctrl+X E    edit buffer in $EDITOR                [keybindings.zsh]
# Ctrl+X^N    navi cheatsheet browser               [plugins.zsh]
# Ctrl+G *    fzf-git.sh object widgets             [junegunn/fzf-git.sh]

bindkey -e   # emacs base keymap

# ── Terminal application mode ─────────────────────────────────────────────────
if (( ${+terminfo[smkx]} && ${+terminfo[rmkx]} )); then
  zle-line-init()   { echoti smkx }
  zle-line-finish() { echoti rmkx }
  zle -N zle-line-init
  zle -N zle-line-finish
fi

# ── Word boundary style ───────────────────────────────────────────────────────
autoload -Uz select-word-style
select-word-style bash   # stop at '/', '-', '.', '=' — matches GUI text fields

# ── Helpers (scoped to this file; unfunction'd at end) ───────────────────────
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
_bk '^[[H'  beginning-of-line
_bk '^[[F'  end-of-line
_bk '^[[1~' beginning-of-line   # rxvt
_bk '^[[4~' end-of-line

# ── Character navigation ──────────────────────────────────────────────────────
_bk '^[[C' forward-char
_bk '^[[D' backward-char
_bk '^[[1;5C' forward-word      # Ctrl+Right
_bk '^[[1;5D' backward-word     # Ctrl+Left
_bk '^[[1;3C' forward-word      # Alt+Right
_bk '^[[1;3D' backward-word     # Alt+Left

# ── Deletion ─────────────────────────────────────────────────────────────────
_bk '^?' backward-delete-char
_bti kdch1 delete-char
_bk '^[[3~' delete-char         # Delete fallback

_bk '^[[3;5~' kill-word         # Ctrl+Delete
_bk '^[[3;5M' kill-word         # Ctrl+Delete (kitty keyboard protocol)

# Ctrl+Backspace: 0x08 universally; ^[[127;5u in kitty full protocol
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
bindkey '^r'   history-incremental-search-backward   # atuin overrides this async
bindkey '^_'   undo
bindkey '^[^_' redo
bindkey '^u'   kill-whole-line
bindkey '^[.'  insert-last-word
bindkey '\ew'  kill-region
bindkey -s '\el' 'ls\n'                              # Alt+L: quick ls

# ── Edit command in $EDITOR ───────────────────────────────────────────────────
# Opens the current buffer in nvim for complex commands, pipelines, heredocs.
autoload -Uz edit-command-line
zle -N edit-command-line
bindkey '^X^E' edit-command-line
bindkey '^Xe'  edit-command-line

# ── Bracketed paste ───────────────────────────────────────────────────────────
autoload -Uz bracketed-paste-magic
zle -N bracketed-paste bracketed-paste-magic

# ── zsh-history-substring-search override ────────────────────────────────────
# Must come after the up/down-line-or-beginning-search binds above.
(( ${+functions[history-substring-search-up]} )) && {
  bindkey '^[[A' history-substring-search-up
  bindkey '^[OA' history-substring-search-up
  bindkey '^[[B' history-substring-search-down
  bindkey '^[OB' history-substring-search-down
}

# ── Custom widgets ────────────────────────────────────────────────────────────
# ~*.zwc excludes compiled binary files; widgets/ is sourced entirely.
for _f in "$ZCONFDIR/widgets"/**/^*.zwc(.N); do builtin source "$_f"; done
unset _f

# ── Cleanup ───────────────────────────────────────────────────────────────────
unfunction _bk _bti
