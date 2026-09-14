# zimfw/post.zsh — Load Zim, restore authoritative completion styles,
# apply post-load plugin compatibility fixes, then schedule async byte-compilation.
#
# Load order at this point:
#   1. core/completion.zsh has already established pre-compinit styles/cache.
#   2. ZIM_HOME/init.zsh loads Zim modules.
#   3. Zim's completion module runs compinit and installs its own zstyles.
#   4. fzf-tab loads after compinit.
#   5. This file then reapplies our completion policy and compatibility fixes.

source "$ZIM_HOME/init.zsh"

# ══════════════════════════════════════════════════════════════════════════════
# Restore authoritative completion policy
# ══════════════════════════════════════════════════════════════════════════════
#
# Zim's completion module installs its own runtime zstyles after compinit,
# including more-specific menu settings. Re-source our idempotent completion
# configuration so our intended fzf-tab-compatible policy wins last.
#
# In particular this restores:
#
#   zstyle ':completion:*' menu no
#   zstyle ':completion:*:*:cd:*:directory-stack' menu no
#   zstyle ':completion:*:history-words' menu no
#
# along with our matcher, grouping, colours, process completion and cache policy.

source "$ZCONFDIR/core/completion.zsh"


# ══════════════════════════════════════════════════════════════════════════════
# fzf-tab: materialise -ftb-generate-complist
# ══════════════════════════════════════════════════════════════════════════════
#
# Upstream fzf-tab issue #574 affects recent fzf-tab releases on Zsh 5.9:
#
#   https://github.com/Aloxaf/fzf-tab/issues/574
#
# The failure mode matches this configuration exactly:
#
#   ls /etc/<TAB>
#
# produces no candidates through fzf-tab, while:
#
#   disable-fzf-tab
#
# immediately restores ordinary Zsh path completion.
#
# In the upstream report, fzf-tab correctly captures compsys candidates in
# _ftb_compcap but its autoloaded -ftb-generate-complist produces an empty
# _ftb_complist. Defining/materialising the same function normally avoids the
# faulty autoload execution path.
#
# `functions -c oldfn newfn` is a native Zsh mechanism for copying functions.
# If oldfn is marked for autoload, Zsh loads it before making the copy.
#
# Keep this isolated here so it can be removed cleanly after fzf-tab fixes the
# upstream regression.

if (( ${+functions[-ftb-generate-complist]} )); then
  if functions -c -- \
      -ftb-generate-complist \
      _ftb_generate_complist_materialized 2>/dev/null
  then
    unfunction -- -ftb-generate-complist 2>/dev/null

    functions -c -- \
      _ftb_generate_complist_materialized \
      -ftb-generate-complist

    unfunction -- _ftb_generate_complist_materialized
  fi
fi


# ══════════════════════════════════════════════════════════════════════════════
# Async byte-compilation
# ══════════════════════════════════════════════════════════════════════════════

_zcompile_configs() {
  local -a targets=(
    "$ZDOTDIR"/.zshrc(N.)
    "$ZDOTDIR"/.zshenv(N.)
    "$ZDOTDIR"/.zprofile(N.)
    "$ZCONFDIR"/zimfw/*.zsh(N.)
    "$ZCONFDIR"/core/*.zsh(N.)
    "$ZCONFDIR"/fzf/*.zsh(N.)
    "$ZCONFDIR"/tools/*.zsh(N.)
    "$ZCONFDIR"/hooks/*.zsh(N.)
    "$ZCONFDIR"/hooks/precmd/*.zsh(N.)
    "$ZCONFDIR"/widgets/*.zsh(N.)
    "$ZCONFDIR"/functions.zsh(N.)
    "$ZCONFDIR"/keybindings.zsh(N.)
  )

  local f

  for f in $targets; do
    if [[ ! -f ${f}.zwc || $f -nt ${f}.zwc ]]; then
      zcompile "$f" 2>/dev/null
    fi
  done

  unfunction _zcompile_configs
}

zsh-defer _zcompile_configs
