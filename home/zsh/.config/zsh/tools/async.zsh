# tools/async.zsh — Tool integrations after Zim/plugin initialisation.
# Sourced AFTER zimfw/post.zsh, so compinit and all Zim modules are available.
# Plugin configuration itself lives in tools/env.zsh and is set pre-load.

# ══════════════════════════════════════════════════════════════════════════════
# Prompt / completion integrations that must be ready immediately
# ══════════════════════════════════════════════════════════════════════════════
# Starship must register its prompt hooks before the first prompt is drawn.
# Preserve first-run auto-install behaviour from the original configuration.
if ! command -v starship &>/dev/null; then
  curl -fsSL https://starship.rs/install.sh \
    | sh -s -- --yes --bin-dir "$HOME/.local/bin"
  rehash
fi
command -v starship &>/dev/null && _cached_eval starship init zsh

# Carapace needs compinit to have already run. Register synchronously so its
# completions are available on the first Tab press; fzf-tab displays whatever
# compsys/compdef returns, including Carapace candidates.
command -v carapace &>/dev/null \
  && _cached_eval carapace _carapace zsh

# ══════════════════════════════════════════════════════════════════════════════
# Deferred integrations
# ══════════════════════════════════════════════════════════════════════════════
# zoxide: replace cd with frecency-aware navigation while keeping zi.
command -v zoxide &>/dev/null \
  && zsh-defer -c '_cached_eval zoxide init zsh --cmd cd'

# Atuin: own Ctrl+R but intentionally leave Up/Down to history-substring-search.
# Until this deferred init runs, fzf/native history remains a harmless fallback.
command -v atuin &>/dev/null \
  && zsh-defer -c '_cached_eval atuin init zsh --disable-up-arrow'

# direnv: per-directory environment loading.
command -v direnv &>/dev/null \
  && zsh-defer -c '_cached_eval direnv hook zsh'

# mise: runtime/toolchain environment.
command -v mise &>/dev/null \
  && zsh-defer -c '_cached_eval mise activate zsh'

# Rebuild the command hash after deferred tools may have extended PATH.
zsh-defer rehash
