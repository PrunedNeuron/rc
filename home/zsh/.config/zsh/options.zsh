# $ZCONFDIR/options.zsh — Zsh setopt configuration

# ── Core behaviour ────────────────────────────────────────────────────────────
setopt INTERACTIVE_COMMENTS   # allow # comments at the prompt
setopt SHORT_LOOPS            # allow short for/if/while/select forms
setopt NO_FLOW_CONTROL        # free Ctrl+S / Ctrl+Q from XON/XOFF flow control

# ── History ───────────────────────────────────────────────────────────────────
setopt APPEND_HISTORY
setopt INC_APPEND_HISTORY
setopt SHARE_HISTORY
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_FIND_NO_DUPS
setopt HIST_REDUCE_BLANKS
setopt EXTENDED_HISTORY
setopt HIST_IGNORE_SPACE

# ── Completion ────────────────────────────────────────────────────────────────
setopt AUTO_LIST
setopt AUTO_MENU
setopt ALWAYS_TO_END
setopt LIST_TYPES
setopt COMPLETE_IN_WORD       # complete from both ends of a word, not just end
# Enable tab completion after '=' in '--flag=<TAB>'. Without this, completions
# for '--output=', '--format=', etc. silently produce empty lists.
setopt MAGIC_EQUAL_SUBST

# ── Directory navigation ──────────────────────────────────────────────────────
setopt AUTO_CD
setopt AUTO_PUSHD
setopt PUSHD_IGNORE_DUPS      # no duplicate entries in the dir stack
setopt PUSHD_SILENT           # suppress stack printout on cd

# ── Globbing ──────────────────────────────────────────────────────────────────
setopt EXTENDED_GLOB
setopt NOMATCH

# ── Job control ───────────────────────────────────────────────────────────────
setopt NOTIFY
setopt LONG_LIST_JOBS         # verbose job list format (pid, status, command)
setopt NO_BG_NICE             # background jobs run at same CPU priority as fg

# ── Unicode ───────────────────────────────────────────────────────────────────
# Correct ZLE handling of combining Unicode codepoints (diacritics, etc.).
setopt COMBINING_CHARS

# ── Quoting ───────────────────────────────────────────────────────────────────
# Permits '' as a literal single-quote inside single-quoted strings.
# e.g.: echo 'it''s fine'  → it's fine
setopt RC_QUOTES
