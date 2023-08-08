# ZSH Options


## -- Basics

# Allow comments in interactive shell
setopt INTERACTIVE_COMMENTS


## -- History

# Allow multiple terminal sessions to all append to one zsh command history
setopt APPEND_HISTORY

# Save history entries as soon as they are entered
setopt INC_APPEND_HISTORY

# Remove older duplicate entries from history
setopt HIST_IGNORE_ALL_DUPS

# When searching history don't display results already cycled through twice
setopt HIST_FIND_NO_DUPS

# Remove superfluous blanks from each line being added to history
setopt HIST_REDUCE_BLANKS

# Include more information about when the command was executed, etc
setopt EXTENDED_HISTORY

# Share history between different zsh instances
setopt SHARE_HISTORY

# Remove lines from the history list when the first character is a space, or when one of the expanded aliases contains a leading space.
setopt HIST_IGNORE_SPACE

## -- Completion

# Automatically list choices on an ambiguous completion.
setopt AUTO_LIST

# Automatically use menu completion after the second consecutive request for completion,
# for example by pressing the tab key repeatedly.
setopt AUTO_MENU

# Move cursor to end if word had one match
setopt ALWAYS_TO_END

# Allow completion from within a word/phrase
setopt COMPLETE_IN_WORD

# Complete aliases
# setopt COMPLETE_ALIASES

# Show the type of each file with a trailing identifying mark
# setopt LIST_TYPES

## -- Changing directories

# Make cd push the old directory onto the directory stack
setopt AUTO_PUSHD

# cd by typing directory name if it's not a command
setopt AUTO_CD

## -- Expansions & Globbing

# Print an error instead of leaving filename generation incomplete if no matches
setopt NOMATCH

# Treat the ‘#’, ‘~’ and ‘^’ characters as part of patterns for filename generation
setopt EXTENDED_GLOB


## -- Job control

# Report the status of background jobs immediately, rather than waiting to print
setopt NOTIFY


## -- ZLE

# Beep on error in ZLE
setopt BEEP


## -- Input / Output

# Try to correct the spelling of commands
#setopt CORRECT

# Allow the short forms of for, repeat, select, if and function constructs
setopt SHORT_LOOPS
