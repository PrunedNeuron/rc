# tools/async.zsh — Plugin post-load configuration + tool initialisation.
# Sourced AFTER zimfw/post.zsh; zsh-defer and all plugins are available.
#
# Sync:  Starship, carapace (both must be ready before the first prompt/Tab).
# Async: zoxide, atuin, direnv, mise (heavier inits; first-prompt latency).

# ── zsh-autosuggestions ───────────────────────────────────────────────────────
# Ghost text: dim italic suggestion appears after the cursor as you type.
# Right arrow / End accepts the full suggestion.
# Alt+Right accepts word-by-word (using select-word-style shell boundaries).
ZSH_AUTOSUGGEST_STRATEGY=(abbreviations history completion)
ZSH_AUTOSUGGEST_BUFFER_MAX_SIZE=20
ZSH_AUTOSUGGEST_USE_ASYNC=1
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=#585b70,italic'   # Catppuccin Mocha surface2

# ── zsh-syntax-highlighting: Catppuccin Mocha ────────────────────────────────
ZSH_HIGHLIGHT_HIGHLIGHTERS=(main brackets pattern)

typeset -A ZSH_HIGHLIGHT_STYLES
# Commands
ZSH_HIGHLIGHT_STYLES[unknown-token]='fg=#f38ba8,bold'
ZSH_HIGHLIGHT_STYLES[reserved-word]='fg=#cba6f7,bold'
ZSH_HIGHLIGHT_STYLES[alias]='fg=#89dceb'
ZSH_HIGHLIGHT_STYLES[suffix-alias]='fg=#89dceb'
ZSH_HIGHLIGHT_STYLES[global-alias]='fg=#89dceb'
ZSH_HIGHLIGHT_STYLES[builtin]='fg=#89b4fa'
ZSH_HIGHLIGHT_STYLES[function]='fg=#89b4fa'
ZSH_HIGHLIGHT_STYLES[command]='fg=#a6e3a1'
ZSH_HIGHLIGHT_STYLES[precommand]='fg=#f9e2af,italic'
ZSH_HIGHLIGHT_STYLES[commandseparator]='fg=#cba6f7'
ZSH_HIGHLIGHT_STYLES[autodirectory]='fg=#fab387,underline'
ZSH_HIGHLIGHT_STYLES[arg0]='fg=#cdd6f4'
# Arguments & paths
ZSH_HIGHLIGHT_STYLES[path]='fg=#cdd6f4,underline'
ZSH_HIGHLIGHT_STYLES[path_pathseparator]='fg=#f38ba8,underline'
ZSH_HIGHLIGHT_STYLES[path_prefix]='fg=#cdd6f4,underline'
ZSH_HIGHLIGHT_STYLES[path_prefix_pathseparator]='fg=#f38ba8,underline'
ZSH_HIGHLIGHT_STYLES[globbing]='fg=#fab387'
ZSH_HIGHLIGHT_STYLES[history-expansion]='fg=#cba6f7'
ZSH_HIGHLIGHT_STYLES[assign]='fg=#cdd6f4'
# Redirection
ZSH_HIGHLIGHT_STYLES[redirection]='fg=#f9e2af,bold'
ZSH_HIGHLIGHT_STYLES[named-fd]='fg=#f9e2af'
ZSH_HIGHLIGHT_STYLES[numeric-fd]='fg=#f9e2af'
ZSH_HIGHLIGHT_STYLES[process-substitution]='fg=#f5e0dc'
ZSH_HIGHLIGHT_STYLES[process-substitution-delimiter]='fg=#f5e0dc'
# Quoting
ZSH_HIGHLIGHT_STYLES[single-quoted-argument]='fg=#a6e3a1'
ZSH_HIGHLIGHT_STYLES[double-quoted-argument]='fg=#a6e3a1'
ZSH_HIGHLIGHT_STYLES[dollar-quoted-argument]='fg=#a6e3a1'
ZSH_HIGHLIGHT_STYLES[rc-quote]='fg=#a6e3a1'
ZSH_HIGHLIGHT_STYLES[dollar-double-quoted-argument]='fg=#cba6f7'
ZSH_HIGHLIGHT_STYLES[back-double-quoted-argument]='fg=#cba6f7'
ZSH_HIGHLIGHT_STYLES[back-dollar-quoted-argument]='fg=#cba6f7'
# Command substitution
ZSH_HIGHLIGHT_STYLES[command-substitution]='fg=#f5e0dc'
ZSH_HIGHLIGHT_STYLES[command-substitution-quoted]='fg=#f5e0dc'
ZSH_HIGHLIGHT_STYLES[command-substitution-delimiter]='fg=#f5e0dc,bold'
ZSH_HIGHLIGHT_STYLES[command-substitution-delimiter-quoted]='fg=#f5e0dc,bold'
# Comments
ZSH_HIGHLIGHT_STYLES[comment]='fg=#585b70,italic'
# Brackets
ZSH_HIGHLIGHT_STYLES[bracket-error]='fg=#f38ba8,bold'
ZSH_HIGHLIGHT_STYLES[bracket-level-1]='fg=#cba6f7,bold'
ZSH_HIGHLIGHT_STYLES[bracket-level-2]='fg=#f9e2af,bold'
ZSH_HIGHLIGHT_STYLES[bracket-level-3]='fg=#a6e3a1,bold'
ZSH_HIGHLIGHT_STYLES[bracket-level-4]='fg=#89b4fa,bold'
ZSH_HIGHLIGHT_STYLES[bracket-level-5]='fg=#f38ba8,bold'
ZSH_HIGHLIGHT_STYLES[cursor-matchingbracket]='standout'

# ── zsh-history-substring-search ─────────────────────────────────────────────
HISTORY_SUBSTRING_SEARCH_FUZZY=1
HISTORY_SUBSTRING_SEARCH_ENSURE_UNIQUE=1
HISTORY_SUBSTRING_SEARCH_HIGHLIGHT_FOUND='bg=#313244,fg=#cba6f7,bold'
HISTORY_SUBSTRING_SEARCH_HIGHLIGHT_NOT_FOUND='bg=#313244,fg=#f38ba8,bold'

# ── Starship (synchronous) ────────────────────────────────────────────────────
# Must register its precmd hook before the first prompt draw.
command -v starship &>/dev/null \
  || curl -sS https://starship.rs/install.sh | sh -s -- --yes --bin-dir "$HOME/.local/bin"
_cached_eval starship init zsh

# ── carapace (synchronous) ────────────────────────────────────────────────────
# Initialised synchronously to ensure compdef registrations are in place before
# the first <TAB> press. _cached_eval makes this effectively a single `source`
# of a cached file (~1ms when binary is unchanged), so startup cost is negligible.
#
# Coverage: docker, cargo, kubectl, helm, gh, poetry, npm, pip3, terraform,
# rclone, restic, and hundreds more — filling every gap left by the native zsh
# completion system and zsh-users/zsh-completions.
#
# Priority (controlled by CARAPACE_BRIDGES='zsh,fish,bash'):
#   native zsh compdef > carapace zsh spec > fish bridge > bash bridge
command -v carapace &>/dev/null && _cached_eval carapace _carapace zsh

# ── Async tool initialisations ────────────────────────────────────────────────
# These are heavier (network/file scanning) and do not need to be ready for the
# first keypress; zsh-defer runs them after the first prompt is displayed.

# zoxide: frecency-aware directory jumping (z / zi replace cd)
zsh-defer -c '_cached_eval zoxide init zsh --cmd cd'

# Atuin: encrypted cross-session history sync.
# --disable-up-arrow: zsh-history-substring-search owns ↑ for prefix search.
zsh-defer -c '_cached_eval atuin init zsh --disable-up-arrow'

# direnv: per-directory .envrc loading
zsh-defer -c 'command -v direnv &>/dev/null && _cached_eval direnv hook zsh'

# mise: polyglot runtime manager (node, python, ruby, go, …)
zsh-defer -c 'command -v mise &>/dev/null && _cached_eval mise activate zsh'

# Rebuild the PATH hash after all async inits have had a chance to extend PATH.
zsh-defer rehash