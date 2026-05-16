# keybindings.zsh — All key bindings.
# ALWAYS sourced last in .zshrc — guarantees our bindings win over anything
# registered by atuin, zoxide, starship, or any zimfw plugin.
#
# ── Widget map ────────────────────────────────────────────────────────────────
# Ctrl+T      file picker (multi, bat preview)               fzf integration
# Ctrl+R      atuin history (fzf fallback in SSH)            atuin / fzf
# Alt+C       directory jump                                  fzf integration
# Alt+G       live ripgrep dual rg/fzf mode                  widgets/grep.zsh
# Alt+M       package hub                                     widgets/pacman.zsh
# Alt+S       systemd hub                                     widgets/systemd.zsh
# Alt+K       process browser/killer                          widgets/process.zsh
# Alt+N       SSH/network host picker                         widgets/ssh.zsh
# Alt+E       environment variable browser                    widgets/env-browser.zsh
# Alt+I       man page browser (nvim)                         widgets/man.zsh
# Alt+O       Docker hub                                      widgets/docker.zsh
# Ctrl+D      smart double-press exit                         widgets/ctrl-d.zsh
# Ctrl+X E    edit buffer in $EDITOR                          edit-command-line
# Ctrl+X N    navi cheatsheet browser                         (inline below)
# Ctrl+G *    fzf-git.sh object widgets                       zimfw: fzf-git.sh
#
# ── Multi-select ──────────────────────────────────────────────────────────────
# Ctrl+Space  toggle-mark + down    (FZF_DEFAULT_OPTS)
# Ctrl+A      toggle-all            (FZF_DEFAULT_OPTS)
# Tab         accept + insert all   (fzf-tab)

bindkey -e   # Emacs base keymap

# ══════════════════════════════════════════════════════════════════════════════
# Terminal application mode (smkx / rmkx)
# ══════════════════════════════════════════════════════════════════════════════
# Puts the terminal into application mode while ZLE is active, so cursor and
# function keys emit the escape sequences that terminfo(5) bindings expect.
# add-zle-hook-widget (not zle -N zle-line-init) allows multiple hooks on the
# same event without any replacing the previous registration.
#
# Kitty full-keyboard-protocol note: the smkx/rmkx calls are harmless when
# kitty's CSI-u protocol is active — kitty ignores them. Keeping them here
# preserves compatibility with xterm, foot, alacritty, wezterm, tmux, etc.
if (( ${+terminfo[smkx]} && ${+terminfo[rmkx]} )); then
  _zle_smkx() { echoti smkx }
  _zle_rmkx() { echoti rmkx }
  add-zle-hook-widget zle-line-init   _zle_smkx
  add-zle-hook-widget zle-line-finish _zle_rmkx
fi

# ══════════════════════════════════════════════════════════════════════════════
# Word boundary style
# ══════════════════════════════════════════════════════════════════════════════
# select-word-style shell: words delimited by whitespace AND non-WORDCHARS chars.
# This mirrors how GUI text editors treat word boundaries (stop at / - . = @ ,).
# select-word-style bash (whitespace only) would kill entire paths at once.
autoload -Uz select-word-style
select-word-style shell
# Remove / and & from WORDCHARS so they act as word boundaries:
#   /  — path separator: Ctrl+Right stops inside /usr/local/bin
#   &  — shell operator: stops before & in bg commands
WORDCHARS=${WORDCHARS//[\/&]/}

# ══════════════════════════════════════════════════════════════════════════════
# URL quoting + bracketed paste
# ══════════════════════════════════════════════════════════════════════════════
# url-quote-magic: auto-escapes ? & = % # in typed/pasted URLs.
# bracketed-paste-magic: integrates with url-quote-magic for pasted URLs.
autoload -Uz url-quote-magic bracketed-paste-magic
zle -N self-insert url-quote-magic
zle -N bracketed-paste bracketed-paste-magic

# ══════════════════════════════════════════════════════════════════════════════
# Helpers (unfunction'd at end of file)
# ══════════════════════════════════════════════════════════════════════════════
# _bk: bind a key in emacs + viins + vicmd simultaneously
_bk()  { bindkey -M emacs "$1" "$2"; bindkey -M viins "$1" "$2"; bindkey -M vicmd "$1" "$2" }
# _bti: bind via terminfo capability name (no-op if capability absent)
_bti() { [[ -n ${terminfo[$1]} ]] && _bk "${terminfo[$1]}" "$2" }

# ══════════════════════════════════════════════════════════════════════════════
# History navigation
# ══════════════════════════════════════════════════════════════════════════════
# up-line-or-beginning-search: prefix-searches history when buffer is non-empty;
# falls back to plain up-line-or-history on empty buffer.
# These bindings are later overridden by history-substring-search (below).
autoload -Uz up-line-or-beginning-search down-line-or-beginning-search
zle -N up-line-or-beginning-search
zle -N down-line-or-beginning-search

_bti kpp   up-line-or-history
_bti knp   down-line-or-history
_bti kcuu1 up-line-or-beginning-search
_bti kcud1 down-line-or-beginning-search

# Escape-sequence fallbacks (xterm, foot, kitty legacy, tmux)
_bk '^[[A' up-line-or-beginning-search
_bk '^[OA' up-line-or-beginning-search
_bk '^[[B' down-line-or-beginning-search
_bk '^[OB' down-line-or-beginning-search

# ══════════════════════════════════════════════════════════════════════════════
# History-substring-search override
# ══════════════════════════════════════════════════════════════════════════════
# MUST follow the fallback registrations above. Overwrites ↑/↓ with the
# substring-search variants when the plugin loaded successfully.
(( ${+functions[history-substring-search-up]} )) && {
  bindkey '^[[A' history-substring-search-up
  bindkey '^[OA' history-substring-search-up
  bindkey '^[[B' history-substring-search-down
  bindkey '^[OB' history-substring-search-down
}

# ══════════════════════════════════════════════════════════════════════════════
# Line navigation — Home / End / Page Up / Page Down
# ══════════════════════════════════════════════════════════════════════════════
_bti khome beginning-of-line
_bti kend  end-of-line
_bk '^[[H'  beginning-of-line
_bk '^[[F'  end-of-line
_bk '^[[1~' beginning-of-line      # rxvt / VT100
_bk '^[[4~' end-of-line
_bk '^[[5~' up-line-or-history
_bk '^[[6~' down-line-or-history

# ══════════════════════════════════════════════════════════════════════════════
# Character and word navigation
# ══════════════════════════════════════════════════════════════════════════════
_bk '^[[C' forward-char
_bk '^[[D' backward-char

# Ctrl+Arrow
_bk '^[[1;5C' forward-word
_bk '^[[1;5D' backward-word
_bk '^[[C;5u'  forward-word        # kitty full-keyboard-protocol
_bk '^[[D;5u'  backward-word

# Alt+Arrow
_bk '^[[1;3C' forward-word
_bk '^[[1;3D' backward-word
_bk '^[[C;3u' forward-word         # kitty
_bk '^[[D;3u' backward-word

# ══════════════════════════════════════════════════════════════════════════════
# Deletion
# ══════════════════════════════════════════════════════════════════════════════
_bk '^?' backward-delete-char      # Backspace (DEL 0x7F) — universal

_bti kdch1 delete-char
_bk '^[[3~' delete-char            # Delete key (xterm, kitty, foot, tmux)

# Ctrl+Delete → kill-word (forward)
_bk '^[[3;5~' kill-word
_bk '^[[3;5M' kill-word            # kitty keyboard protocol

# Ctrl+Backspace → backward-kill-word
# ^H (0x08) is the same code as Ctrl+H in legacy terminals; both must map here.
# With select-word-style shell, this stops at / - . = boundaries, not just space.
_bk '^H'        backward-kill-word
_bk '^[[127;5u' backward-kill-word # kitty full-keyboard-protocol

# Alt+Backspace → backward-kill-word (standard readline behaviour)
_bk '^[^?' backward-kill-word
_bk '^[^H' backward-kill-word

# ══════════════════════════════════════════════════════════════════════════════
# Completion
# ══════════════════════════════════════════════════════════════════════════════
_bti kcbt reverse-menu-complete
_bk '^[[Z' reverse-menu-complete   # Shift+Tab: walk backwards through menu

# ══════════════════════════════════════════════════════════════════════════════
# Editing utilities
# ══════════════════════════════════════════════════════════════════════════════
bindkey ' '    magic-space          # Space expands history (!! !$)
bindkey '^r'   history-incremental-search-backward  # overridden by atuin (async)
bindkey '^_'   undo
bindkey '^[^_' redo
bindkey '^u'   kill-whole-line      # Ctrl+U: clear entire line (readline compat)
bindkey '^[.'  insert-last-word     # Alt+.: cycle through last arguments
bindkey '\ew'  kill-region          # Alt+W: kill the visual selection
bindkey -s '\el' 'ls\n'            # Alt+L: quick ls shortcut

# ── Edit buffer in $EDITOR ────────────────────────────────────────────────────
# Opens the current ZLE buffer in nvim for multi-line commands, heredocs, etc.
autoload -Uz edit-command-line
zle -N edit-command-line
bindkey '^X^E' edit-command-line
bindkey '^Xe'  edit-command-line

# ── navi: interactive cheatsheet browser ─────────────────────────────────────
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

# ══════════════════════════════════════════════════════════════════════════════
# Cleanup
# ══════════════════════════════════════════════════════════════════════════════
unfunction _bk _bti