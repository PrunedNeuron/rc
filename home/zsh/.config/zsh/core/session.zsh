# core/session.zsh — Early interactive-session bootstrap.
#
# Must be sourced before Zim/plugins.
#
# Responsibilities:
#   • establish the base ZLE keymap;
#   • import shell-agnostic environment fragments;
#   • expose user-installed executables before plugin/tool initialisation.

# ══════════════════════════════════════════════════════════════════════════════
# Base keymap
# ══════════════════════════════════════════════════════════════════════════════
#
# Select the base keymap before fzf, fzf-tab, autosuggestions, etc. install
# or wrap widgets.
#
# keybindings.zsh must NOT call `bindkey -e` later, because doing so would reset
# plugin-installed bindings.

bindkey -e


# ══════════════════════════════════════════════════════════════════════════════
# Shell-agnostic environment fragments
# ══════════════════════════════════════════════════════════════════════════════

for _session_fragment in "$XDG_CONFIG_HOME/shell"/**/*(.N); do
  emulate bash -c "source $_session_fragment"
done
unset _session_fragment


# ══════════════════════════════════════════════════════════════════════════════
# User executable path
# ══════════════════════════════════════════════════════════════════════════════

typeset -U path PATH

if [[ -d $HOME/.local/bin ]]; then
  path=("$HOME/.local/bin" $path)
fi
