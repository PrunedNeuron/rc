# $ZCONFDIR/options.zsh
# Zsh Options Configuration

# ===========================
# Basic Shell Behavior
# ===========================

# Allow comments in interactive shell
setopt INTERACTIVE_COMMENTS

# Allow short forms of for, repeat, select, if, and function constructs
setopt SHORT_LOOPS

# ===========================
# History Configuration
# ===========================

# Append history instead of overwriting
setopt APPEND_HISTORY

# Incrementally append history as commands are entered
setopt INC_APPEND_HISTORY

# Share command history across all sessions
setopt SHARE_HISTORY

# Ignore duplicate commands in history
setopt HIST_IGNORE_ALL_DUPS

# Avoid displaying duplicate history entries during search
setopt HIST_FIND_NO_DUPS

# Remove superfluous blanks from each history entry
setopt HIST_REDUCE_BLANKS

# Record timestamp and other metadata for each history entry
setopt EXTENDED_HISTORY

# Ignore commands that start with a space
setopt HIST_IGNORE_SPACE

# ===========================
# Completion Behavior
# ===========================

# Automatically list choices on ambiguous completion
setopt AUTO_LIST

# Use menu completion after multiple tab presses
setopt AUTO_MENU

# Move cursor to end if the completed word has a single match
setopt ALWAYS_TO_END

# Show file types with a trailing identifier
setopt LIST_TYPES

# ===========================
# Directory Navigation
# ===========================

# Automatically push the old directory onto the stack when changing directories
setopt AUTO_PUSHD

# Change directory by typing the directory name if it's not a command
setopt AUTO_CD

# ===========================
# Globbing and Expansion
# ===========================

# Treat special characters like '#', '~', and '^' as part of patterns
setopt EXTENDED_GLOB

# Print an error if filename generation fails (no matches found)
setopt NOMATCH

# ===========================
# Job Control
# ===========================

# Report the status of background jobs immediately
setopt NOTIFY

# ===========================
# Zsh Line Editor (ZLE)
# ===========================

# Beep on errors in ZLE
setopt BEEP
