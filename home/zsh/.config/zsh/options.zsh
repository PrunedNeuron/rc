# $ZCONFDIR/options.zsh — shell behaviour flags.

# ── Core ──────────────────────────────────────────────────────────────────────
setopt INTERACTIVE_COMMENTS   # allow # comments at the prompt
setopt SHORT_LOOPS            # permit one-liner for/if/while/select
setopt NO_FLOW_CONTROL        # free Ctrl+S / Ctrl+Q from XON/XOFF
setopt NO_BEEP                # silence the terminal bell
setopt MULTIOS                # allow multiple redirections: cmd >a >b
setopt RC_QUOTES              # '' = literal ' inside single-quoted strings
setopt COMBINING_CHARS        # correct ZLE handling of Unicode combining chars
setopt NO_MAIL_WARNING        # suppress "you have new mail" notices

# ── Spell correction ──────────────────────────────────────────────────────────
setopt CORRECT                # suggest correction for mistyped command names
unsetopt CORRECT_ALL          # argument correction is too noisy in practice

# ── History ───────────────────────────────────────────────────────────────────
# SHARE_HISTORY implies INC_APPEND_HISTORY. The zsh manual explicitly states
# INC_APPEND_HISTORY "should not be used together with SHARE_HISTORY".
setopt SHARE_HISTORY          # import new commands from histfile in real time
setopt HIST_IGNORE_ALL_DUPS   # delete older duplicate entry when re-running a command
setopt HIST_FIND_NO_DUPS      # don't show duplicates in history search
setopt HIST_SAVE_NO_DUPS      # don't write duplicate entries to histfile
setopt HIST_EXPIRE_DUPS_FIRST # expire duplicates first when trimming histfile
setopt HIST_REDUCE_BLANKS     # normalise whitespace before saving
setopt EXTENDED_HISTORY       # record timestamp and duration (: start:elapsed;cmd)
setopt HIST_IGNORE_SPACE      # don't record commands prefixed with a space

# ── Completion ────────────────────────────────────────────────────────────────
setopt AUTO_LIST              # automatically list choices on ambiguous completion
setopt AUTO_MENU              # show completion menu on second Tab
setopt ALWAYS_TO_END          # move cursor to end after completion
setopt LIST_TYPES             # show type indicators (/ * @ =) in listings
setopt COMPLETE_IN_WORD       # complete from both ends of a word
setopt MAGIC_EQUAL_SUBST      # complete after = in --flag=<TAB>

# ── Directory navigation ──────────────────────────────────────────────────────
setopt AUTO_CD                # bare directory name → cd
setopt AUTO_PUSHD             # cd pushes onto dir stack
setopt PUSHD_IGNORE_DUPS      # no duplicate dir-stack entries
setopt PUSHD_SILENT           # suppress stack dump on each cd

# ── Globbing ──────────────────────────────────────────────────────────────────
setopt EXTENDED_GLOB          # enable #, ~, ^ glob operators
setopt NOMATCH                # error (not empty) when a glob matches nothing

# ── Job control ───────────────────────────────────────────────────────────────
setopt NOTIFY                 # report job status immediately
setopt LONG_LIST_JOBS         # verbose job format (pid, status, cmd)
setopt NO_BG_NICE             # background jobs run at same priority as fg
