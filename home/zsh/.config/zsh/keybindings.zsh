# keybindings.zsh — Final explicit user key bindings.
# ALWAYS sourced last so intentional bindings win.
#
# IMPORTANT: the base Emacs keymap is selected near the top of ~/.zshrc.
# Do NOT call `bindkey -e` here: doing so would reset plugin-installed bindings,
# most importantly fzf-tab's ^I widget.
#
# ── Widget map ────────────────────────────────────────────────────────────────
# Ctrl+T      file picker (multi, preview)                    fzf
# Ctrl+R      Atuin history (fzf/native fallback pre-init)    atuin / fzf
# Alt+C       directory jump                                  fzf
# Alt+G       live ripgrep                                    widgets/grep.zsh
# Alt+M       package hub                                     widgets/pacman.zsh
# Alt+S       systemd hub                                     widgets/systemd.zsh
# Alt+K       process browser/killer                          widgets/process.zsh
# Alt+N       SSH/network host picker                         widgets/ssh.zsh
# Alt+E       environment variable browser                    widgets/env-browser.zsh
# Alt+I       man page browser                                widgets/man.zsh
# Alt+O       Docker hub                                      widgets/docker.zsh
# Ctrl+D      smart double-press exit                         widgets/ctrl-d.zsh
# Ctrl+X E    edit buffer in $EDITOR                          edit-command-line
# Ctrl+X N    navi cheatsheet browser                         inline below
# Ctrl+G *    fzf-git.sh object widgets                       fzf-git.sh
#
# Inside fzf/fzf-tab:
# Ctrl+Space  toggle mark + down
# Ctrl+A      toggle all
# Tab         accept selection(s) in fzf-tab
# Shift+Tab   move up in fzf-tab

# ══════════════════════════════════════════════════════════════════════════════
# Terminal application mode (smkx / rmkx)
# ══════════════════════════════════════════════════════════════════════════════
if (( ${+terminfo[smkx]} && ${+terminfo[rmkx]} )); then
  _zle_smkx() { echoti smkx }
  _zle_rmkx() { echoti rmkx }
  add-zle-hook-widget zle-line-init   _zle_smkx
  add-zle-hook-widget zle-line-finish _zle_rmkx
fi

# ══════════════════════════════════════════════════════════════════════════════
# Word boundaries
# ══════════════════════════════════════════════════════════════════════════════
autoload -Uz select-word-style
select-word-style shell
WORDCHARS=${WORDCHARS//[\/&]/}

# ══════════════════════════════════════════════════════════════════════════════
# URL quoting + bracketed paste
# ══════════════════════════════════════════════════════════════════════════════
autoload -Uz url-quote-magic bracketed-paste-magic
zle -N self-insert url-quote-magic
zle -N bracketed-paste bracketed-paste-magic

# Helpers.
_bk()  { bindkey -M emacs "$1" "$2"; bindkey -M viins "$1" "$2"; bindkey -M vicmd "$1" "$2" }
_bti() { [[ -n ${terminfo[$1]} ]] && _bk "${terminfo[$1]}" "$2" }

# ══════════════════════════════════════════════════════════════════════════════
# History navigation
# ══════════════════════════════════════════════════════════════════════════════
autoload -Uz up-line-or-beginning-search down-line-or-beginning-search
zle -N up-line-or-beginning-search
zle -N down-line-or-beginning-search

_bti kpp   up-line-or-history
_bti knp   down-line-or-history
_bti kcuu1 up-line-or-beginning-search
_bti kcud1 down-line-or-beginning-search

_bk '^[[A' up-line-or-beginning-search
_bk '^[OA' up-line-or-beginning-search
_bk '^[[B' down-line-or-beginning-search
_bk '^[OB' down-line-or-beginning-search

# Prefer history-substring-search when the plugin is present.
if (( ${+functions[history-substring-search-up]} )); then
  _bk '^[[A' history-substring-search-up
  _bk '^[OA' history-substring-search-up
  _bk '^[[B' history-substring-search-down
  _bk '^[OB' history-substring-search-down

  [[ -n ${terminfo[kcuu1]} ]] && _bk "${terminfo[kcuu1]}" history-substring-search-up
  [[ -n ${terminfo[kcud1]} ]] && _bk "${terminfo[kcud1]}" history-substring-search-down
fi

# ══════════════════════════════════════════════════════════════════════════════
# Line navigation
# ══════════════════════════════════════════════════════════════════════════════
_bti khome beginning-of-line
_bti kend  end-of-line
_bk '^[[H'  beginning-of-line
_bk '^[[F'  end-of-line
_bk '^[[1~' beginning-of-line
_bk '^[[4~' end-of-line
_bk '^[[5~' up-line-or-history
_bk '^[[6~' down-line-or-history

# ══════════════════════════════════════════════════════════════════════════════
# Character / word navigation
# ══════════════════════════════════════════════════════════════════════════════
_bk '^[[C' forward-char
_bk '^[[D' backward-char

# Ctrl+Arrow
_bk '^[[1;5C' forward-word
_bk '^[[1;5D' backward-word
_bk '^[[C;5u' forward-word
_bk '^[[D;5u' backward-word

# Alt+Arrow
_bk '^[[1;3C' forward-word
_bk '^[[1;3D' backward-word
_bk '^[[C;3u' forward-word
_bk '^[[D;3u' backward-word

# ══════════════════════════════════════════════════════════════════════════════
# Deletion
# ══════════════════════════════════════════════════════════════════════════════
_bk '^?' backward-delete-char
_bti kdch1 delete-char
_bk '^[[3~' delete-char

_bk '^[[3;5~' kill-word
_bk '^[[3;5M' kill-word
_bk '^H' backward-kill-word
_bk '^[[127;5u' backward-kill-word
_bk '^[^?' backward-kill-word
_bk '^[^H' backward-kill-word

# ══════════════════════════════════════════════════════════════════════════════
# Completion
# ══════════════════════════════════════════════════════════════════════════════
# Keep Shift+Tab as a native reverse-completion fallback. When fzf-tab's fzf UI
# is active, its own btab binding consumes Shift+Tab before ZLE sees it.
_bti kcbt reverse-menu-complete
_bk '^[[Z' reverse-menu-complete

# ══════════════════════════════════════════════════════════════════════════════
# Editing utilities
# ══════════════════════════════════════════════════════════════════════════════
bindkey ' '    magic-space
# Ctrl+R remains the native history fallback until deferred Atuin init rebinds it.
bindkey '^r'   history-incremental-search-backward
bindkey '^_'   undo
bindkey '^[^_' redo
bindkey '^u'   kill-whole-line
bindkey '^[.'  insert-last-word
bindkey '\ew'  kill-region
bindkey -s '\el' 'ls\n'

# Edit current command line in $EDITOR.
autoload -Uz edit-command-line
zle -N edit-command-line
bindkey '^X^E' edit-command-line
bindkey '^Xe'  edit-command-line

# navi interactive cheatsheet browser.
if command -v navi &>/dev/null; then
  _navi_widget() {
    local _result
    _result=$(
      navi --print --query "$BUFFER" \
           --fzf-overrides "--height=80% --border=rounded --prompt='navi ❯ '"
    ) 2>/dev/null

    if [[ -n $_result ]]; then
      BUFFER="$_result"
      CURSOR=${#BUFFER}
    fi
    zle reset-prompt
  }
  zle -N _navi_widget
  bindkey '^X^N' _navi_widget
  bindkey '^XN'  _navi_widget
fi

unfunction _bk _bti
