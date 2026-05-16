# ~/.zshrc — Interactive shell entry point.
#
# ── Mandatory load order ──────────────────────────────────────────────────────
#  1  zimfw/bootstrap.zsh    zimfw install/rebuild (must be first)
#  2  core/modules.zsh       zmodload (required by hooks + completion)
#  3  core/history.zsh       HISTFILE / HISTSIZE / SAVEHIST
#  4  core/options.zsh       setopt flags
#  5  functions.zsh          fpath + autoload custom functions
#  6  core/completion.zsh    zstyle (MUST precede compinit in zimfw/post.zsh)
#  7  fzf/defaults.zsh       FZF_DEFAULT_OPTS + Catppuccin Mocha palette
#  8  fzf/commands.zsh       Per-widget FZF opts + _fzf_comprun
#  9  fzf/tab.zsh            fzf-tab zstyle (MUST precede compinit)
# 10  tools/env.zsh          _cached_eval + static tool exports
# 11  zimfw/post.zsh         pre-plugin vars → ZIM_HOME/init.zsh (compinit runs here)
#                            → schedule async zcompile
# 12  tools/async.zsh        plugin configs + starship (sync) + zsh-defer: rest
# 13  hooks/hooks.zsh        precmd/preexec hook registration
# 14  widgets/*.zsh           ZLE widget definitions (glob, alpha order)
# 15  keybindings.zsh        ALL keybindings (always last)
# ─────────────────────────────────────────────────────────────────────────────

# Shell-agnostic env fragments (POSIX aliases, PATH extensions, exports).
# emulate bash: files use [[ ]] / export syntax but must affect this shell.
for _f in "$XDG_CONFIG_HOME/shell"/**/*(.N); do emulate bash -c "source $_f"; done
unset _f

source "$ZCONFDIR/zimfw/bootstrap.zsh"
source "$ZCONFDIR/core/modules.zsh"
source "$ZCONFDIR/core/history.zsh"
source "$ZCONFDIR/core/options.zsh"
source "$ZCONFDIR/functions.zsh"
source "$ZCONFDIR/core/completion.zsh"
source "$ZCONFDIR/fzf/defaults.zsh"
source "$ZCONFDIR/fzf/commands.zsh"
source "$ZCONFDIR/fzf/tab.zsh"
source "$ZCONFDIR/tools/env.zsh"
source "$ZCONFDIR/zimfw/post.zsh"
source "$ZCONFDIR/tools/async.zsh"
source "$ZCONFDIR/hooks/hooks.zsh"

for _f in "$ZCONFDIR"/widgets/*.zsh(.N); do source "$_f"; done
unset _f

source "$ZCONFDIR/keybindings.zsh"