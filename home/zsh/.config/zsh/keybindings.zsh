# $ZCONFDIR/keybindings.zsh — all key bindings. Always sourced last.
#
# Load order guarantee: this file is sourced after .zshrc → plugins.zsh,
# so atuin/zoxide/starship hooks are already registered and can be safely
# overridden here.
#
# ── Widget map ────────────────────────────────────────────────────────────────
# Ctrl+T      file picker (multi, bat preview)               fzf shell integration
# Ctrl+R      atuin history (fzf fallback in SSH)            atuin / fzf
# Alt+C       directory jump (fzf shell integration)         fzf shell integration
# Alt+G       live ripgrep dual rg/fzf mode                  widgets/fzf-live-grep.zsh
# Alt+M       package hub (pai/par/pao/pls/pup/pfi/pcc)      widgets/fzf-pacman.zsh
# Alt+S       systemd hub (services/timers/journal/failed)   widgets/fzf-systemd.zsh
# Alt+K       process browser/killer                         widgets/fzf-process.zsh
# Alt+N       SSH/network host picker                        widgets/fzf-ssh.zsh
# Alt+E       environment variable browser                   widgets/fzf-env.zsh
# Alt+I       man page browser (opens in nvim)               widgets/fzf-man.zsh
# Alt+O       Docker hub (containers/images/volumes)         widgets/fzf-docker.zsh
# Alt+P       Wayland clipboard history (cliphist)           widgets/fzf-clipboard.zsh
# Ctrl+X E    edit buffer in $EDITOR                         edit-command-line
# Ctrl+X N    navi cheatsheet browser                        plugins.zsh
# Ctrl+G *    fzf-git.sh object widgets                      junegunn/fzf-git.sh
#
# ── Multi-select reference ────────────────────────────────────────────────────
# All fzf-backed widgets and Tab completion support multi-select.
# Ctrl+Space  toggle-mark item + move down  (FZF_DEFAULT_OPTS)
# Ctrl+A      toggle-all                    (FZF_DEFAULT_OPTS)
# Tab         accept + insert all marked    (fzf-tab fzf-flags)

bindkey -e   # Emacs keymap as the base. vi-mode plugins may extend this.

# ══════════════════════════════════════════════════════════════════════════════
# Terminal application mode
# ══════════════════════════════════════════════════════════════════════════════
# Puts the terminal into "application mode" while the ZLE line editor is active.
# Application mode changes the escape sequences that cursor/function keys emit
# (e.g., Home → \eOH instead of \e[H), which is what the terminfo(5) bindings
# in _bti() below rely on.
#
# IMPLEMENTATION: add-zle-hook-widget (not `zle -N zle-line-init`) so that
# multiple hooks can coexist on the same event. Using `zle -N zle-line-init`
# registers ONE widget and replaces any previous registration; widgets sourced
# afterwards that also use `zle -N zle-line-init` would silently discard our
# echoti call. add-zle-hook-widget appends to a list — all hooks fire in order.
#
# KITTY NOTE: When kitty's full keyboard protocol is active (kitty_keyboard_mode
# or `modify_other_keys`), the terminal handles modifier keys via CSI sequences
# (e.g., Ctrl+Backspace → ^[[127;5u) independently of application mode. The
# smkx/rmkx calls are harmless in that case — kitty ignores them — so keeping
# them here preserves compatibility with other terminals (xterm, foot, alacritty,
# wezterm, etc.) without needing per-terminal guards.
if (( ${+terminfo[smkx]} && ${+terminfo[rmkx]} )); then
  _zle_smkx() { echoti smkx }
  _zle_rmkx() { echoti rmkx }
  add-zle-hook-widget zle-line-init   _zle_smkx
  add-zle-hook-widget zle-line-finish _zle_rmkx
fi

# ══════════════════════════════════════════════════════════════════════════════
# Word boundary style
# ══════════════════════════════════════════════════════════════════════════════
# select-word-style shell  → words delimited by whitespace AND non-WORDCHARS chars.
#   Ctrl+Right / Ctrl+Left / Ctrl+W / Alt+Backspace all stop at:
#   `/  -  .  =  @  ,` (anything not in $WORDCHARS and not alphanumeric).
#   This mirrors how most GUI text editors and readline treat word boundaries.
#
# select-word-style bash   → words delimited by whitespace ONLY.
#   Ctrl+W would kill an entire slash-delimited path at once — too greedy.
#
# zimfw's `environment` module sets WORDCHARS='*?_-.[]~=&;!#$%^(){}<>'.
# We override it below to the shorter set that matches "GUI text field" feel.
autoload -Uz select-word-style
select-word-style shell
# Exclude characters from WORDCHARS that we want to be word boundaries:
#   /  — path separator: stop inside /usr/local/bin
#   &  — shell operator: stop before & in bg commands
WORDCHARS=${WORDCHARS//[\/&]/}

# ══════════════════════════════════════════════════════════════════════════════
# Helpers (scoped to this file; unfunction'd at bottom)
# ══════════════════════════════════════════════════════════════════════════════
# _bk: bind key in emacs + viins + vicmd simultaneously
_bk()  { bindkey -M emacs "$1" "$2"; bindkey -M viins "$1" "$2"; bindkey -M vicmd "$1" "$2" }
# _bti: bind via terminfo capability name (only if the capability exists)
_bti() { [[ -n ${terminfo[$1]} ]] && _bk "${terminfo[$1]}" "$2" }

# ══════════════════════════════════════════════════════════════════════════════
# History navigation
# ══════════════════════════════════════════════════════════════════════════════
# up-line-or-beginning-search: if the buffer is non-empty, prefix-searches
# history (smarter than plain up-line-or-history). If buffer is empty, moves
# to previous history entry — identical to the plain up arrow.
#
# These are registered here so _bk can reference them. They will be overridden
# by the history-substring-search rebind at the bottom (after widget sources).
autoload -Uz up-line-or-beginning-search down-line-or-beginning-search
zle -N up-line-or-beginning-search
zle -N down-line-or-beginning-search

_bti kpp   up-line-or-history
_bti knp   down-line-or-history
_bti kcuu1 up-line-or-beginning-search
_bti kcud1 down-line-or-beginning-search

# Escape-sequence fallbacks — cover xterm, foot, kitty (legacy mode), tmux.
_bk '^[[A' up-line-or-beginning-search
_bk '^[OA' up-line-or-beginning-search
_bk '^[[B' down-line-or-beginning-search
_bk '^[OB' down-line-or-beginning-search

# ══════════════════════════════════════════════════════════════════════════════
# Line navigation — Home / End
# ══════════════════════════════════════════════════════════════════════════════
_bti khome beginning-of-line
_bti kend  end-of-line
_bk '^[[H'  beginning-of-line      # xterm / kitty legacy
_bk '^[[F'  end-of-line
_bk '^[[1~' beginning-of-line      # rxvt / some VT100 emulators
_bk '^[[4~' end-of-line

# Page Up / Page Down (move through history lines, not dirs)
_bk '^[[5~' up-line-or-history
_bk '^[[6~' down-line-or-history

# ══════════════════════════════════════════════════════════════════════════════
# Character and word navigation — arrows, Ctrl+Arrow, Alt+Arrow
# ══════════════════════════════════════════════════════════════════════════════
_bk '^[[C' forward-char
_bk '^[[D' backward-char

# Ctrl+Right / Ctrl+Left — most terminals including kitty legacy mode
_bk '^[[1;5C' forward-word
_bk '^[[1;5D' backward-word
# Kitty full keyboard protocol (CSI u format with modifier bit 5 = Ctrl)
_bk '^[[C;5u'  forward-word
_bk '^[[D;5u'  backward-word

# Alt+Right / Alt+Left
_bk '^[[1;3C' forward-word
_bk '^[[1;3D' backward-word
# Kitty full keyboard protocol Alt+arrow
_bk '^[[C;3u' forward-word
_bk '^[[D;3u' backward-word

# ══════════════════════════════════════════════════════════════════════════════
# Deletion
# ══════════════════════════════════════════════════════════════════════════════
_bk '^?' backward-delete-char      # Backspace (DEL, 0x7F) — universal

_bti kdch1 delete-char             # Delete key via terminfo
_bk '^[[3~' delete-char            # Delete fallback (xterm, kitty, etc.)

# Ctrl+Delete — kill word forward
_bk '^[[3;5~' kill-word            # xterm / kitty legacy
_bk '^[[3;5M' kill-word            # kitty keyboard protocol

# ── Ctrl+Backspace → backward-kill-word ───────────────────────────────────────
# The escape sequence for Ctrl+Backspace is terminal-dependent:
#
#   Terminal              Legacy mode    Full keyboard protocol
#   ─────────────────     ───────────    ──────────────────────
#   xterm / foot          ^H  (0x08)    (protocol not supported)
#   kitty                 ^H  (0x08)    ^[[127;5u
#   wezterm               ^H  (0x08)    ^[[127;5u
#   alacritty             ^H  (0x08)    (protocol not supported)
#   tmux (passthrough)    ^H  (0x08)    ^[[127;5u
#
# ^H is 0x08 and is the SAME code as Ctrl+H in legacy terminals. Both bindings
# must point to the same widget. With select-word-style shell, backward-kill-word
# stops at the nearest / - . = boundary, not at pure whitespace.
_bk '^H'        backward-kill-word   # Ctrl+Backspace (legacy) / Ctrl+H
_bk '^[[127;5u' backward-kill-word   # Ctrl+Backspace (kitty full protocol)

# Alt+Backspace → backward-kill-word (standard readline behaviour)
_bk '^[^?' backward-kill-word
_bk '^[^H' backward-kill-word

# ══════════════════════════════════════════════════════════════════════════════
# Completion
# ══════════════════════════════════════════════════════════════════════════════
_bti kcbt reverse-menu-complete
_bk '^[[Z' reverse-menu-complete    # Shift+Tab: reverse through menu

# ══════════════════════════════════════════════════════════════════════════════
# Editing utilities
# ══════════════════════════════════════════════════════════════════════════════
bindkey ' '    magic-space          # history expansion on Space
bindkey '^r'   history-incremental-search-backward  # atuin overrides this async
bindkey '^_'   undo
bindkey '^[^_' redo
bindkey '^u'   kill-whole-line      # Ctrl+U: clear entire line (readline compat)
bindkey '^[.'  insert-last-word     # Alt+.: cycle last argument from history
bindkey '\ew'  kill-region          # Alt+W: kill the visual region
bindkey -s '\el' 'ls\n'             # Alt+L: quick ls (type-ahead shortcut)

# ── Edit buffer in $EDITOR ────────────────────────────────────────────────────
# Opens the ZLE buffer in nvim for multi-line commands, heredocs, complex pipes.
autoload -Uz edit-command-line
zle -N edit-command-line
bindkey '^X^E' edit-command-line
bindkey '^Xe'  edit-command-line

# ── Bracketed paste ───────────────────────────────────────────────────────────
# url-quote-magic (loaded via widgets/url-quote-magic.zsh) hooks self-insert.
# bracketed-paste-magic integrates with it to correctly handle pasted URLs.
autoload -Uz bracketed-paste-magic
zle -N bracketed-paste bracketed-paste-magic

# ── Source widget files ───────────────────────────────────────────────────────
# Explicit *.zsh glob — unambiguous, no negation operators needed.
# The .zwc compiled counterparts (fzf-docker.zsh.zwc, etc.) are auto-loaded
# by zsh when newer than the source; they must never be sourced directly.
for _f in "$ZCONFDIR"/widgets/**/*.zsh(.N); do
  builtin source "$_f"
done
unset _f
# ══════════════════════════════════════════════════════════════════════════════
# zsh-history-substring-search key override
# ══════════════════════════════════════════════════════════════════════════════
# MUST come AFTER the widget source loop above. Reason: any widget file that
# binds arrow keys would otherwise override this. Placing it last guarantees
# history-substring-search wins the ↑/↓ bindings unconditionally.
#
# zsh-history-substring-search (loaded by zimfw in init/post.zsh) registers
# `history-substring-search-up/down` functions. If the plugin loaded correctly,
# we rebind ↑/↓ to these. If the plugin wasn't loaded (e.g., zimfw install not
# run yet), the earlier up-line-or-beginning-search binds remain as fallback.
(( ${+functions[history-substring-search-up]} )) && {
  bindkey '^[[A' history-substring-search-up
  bindkey '^[OA' history-substring-search-up
  bindkey '^[[B' history-substring-search-down
  bindkey '^[OB' history-substring-search-down
}

# ══════════════════════════════════════════════════════════════════════════════
# Cleanup
# ══════════════════════════════════════════════════════════════════════════════
unfunction _bk _bti
