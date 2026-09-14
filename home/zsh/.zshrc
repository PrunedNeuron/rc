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

# Base keymap MUST be selected before fzf/fzf-tab/autosuggestions bind widgets.
bindkey -e

# Shell-agnostic env fragments (POSIX aliases, PATH extensions, exports).
# emulate bash: files use [[ ]] / export syntax but must affect this shell.
for _f in "$XDG_CONFIG_HOME/shell"/**/*(.N); do emulate bash -c "source $_f"; done
unset _f

# Ensure user-installed executables are visible during plugin/tool initialisation.
typeset -U path PATH
path=("$HOME/.local/bin" $path)

source "$ZCONFDIR/zimfw/bootstrap.zsh"
source "$ZCONFDIR/core/modules.zsh"
source "$ZCONFDIR/core/history.zsh"
source "$ZCONFDIR/core/options.zsh"
source "$ZCONFDIR/functions.zsh"

# Static exports and plugin variables must exist before Zim sources plugins.
source "$ZCONFDIR/tools/env.zsh"

# Completion/fzf styles must exist before compinit/fzf-tab initialisation.
source "$ZCONFDIR/core/completion.zsh"
source "$ZCONFDIR/fzf/defaults.zsh"
source "$ZCONFDIR/fzf/commands.zsh"
source "$ZCONFDIR/fzf/tab.zsh"

# Zim initializes its completion module (including compinit), then fzf-tab and
# the remaining interactive plugins according to .zimrc.
source "$ZCONFDIR/zimfw/post.zsh"

# IMPORTANT: Zim's completion module installs its own zstyles *after* compinit
# (including `menu select` and its own matcher-list). Re-source our completion
# policy now so our fzf-tab-compatible styles are authoritative at runtime.
# core/completion.zsh is intentionally idempotent.
source "$ZCONFDIR/core/completion.zsh"

# Tool integrations that require compinit/plugins to already exist.
source "$ZCONFDIR/tools/async.zsh"
source "$ZCONFDIR/hooks/hooks.zsh"

for _f in "$ZCONFDIR"/widgets/*.zsh(.N); do source "$_f"; done
unset _f

source "$ZCONFDIR/keybindings.zsh"

# >>> mamba initialize >>>
# !! Contents within this block are managed by 'micromamba shell init' !!
export MAMBA_EXE='/usr/bin/micromamba';
export MAMBA_ROOT_PREFIX='/home/ayush/.local/share/micromamba';
__mamba_setup="$("$MAMBA_EXE" shell hook --shell zsh --root-prefix "$MAMBA_ROOT_PREFIX" 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__mamba_setup"
else
    alias micromamba="$MAMBA_EXE"  # Fallback on help from micromamba activate
fi
unset __mamba_setup
# <<< mamba initialize <<<
