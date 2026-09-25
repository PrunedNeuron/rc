# zimfw/post.zsh — Load Zim modules and restore authoritative completion policy.
#
# Before this file:
#
#   • completion providers/configuration are prepared;
#   • fzf/fzf-tab zstyles are defined;
#   • Zim plugins have not yet been sourced.
#
# $ZIM_HOME/init.zsh loads modules according to ~/.zimrc.
#
# The important completion sequence is:
#
#   zsh-completions
#   fzf
#   completion      ← runs compinit
#   fzf-tab         ← loads after compinit
#
# Zim's completion module installs runtime zstyles of its own, so our
# idempotent core/completion.zsh is applied once more afterward.

source "$ZIM_HOME/init.zsh"

source "$ZCONFDIR/core/completion.zsh"
