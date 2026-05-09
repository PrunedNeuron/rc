# $ZCONFDIR/init/post.zsh — source zimfw init; async byte-compile configs.

# ── Plugin pre-configuration ──────────────────────────────────────────────────
# These variables are checked by plugins AT SOURCE TIME inside ZIM_HOME/init.zsh.
# Setting them here, immediately before that source call, is the only correct
# location. Setting them in plugins.zsh (sourced after init/post.zsh) is too
# late — the plugins have already read the variables and acted on them.
#
# ZSH_AUTOSUGGEST_MANUAL_REBIND: Without this, zsh-autosuggestions registers a
# precmd hook (_zsh_autosuggest_start) that calls _zsh_autosuggest_bind_widgets
# on every prompt. That function re-wraps every ZLE widget. With any syntax
# highlighting plugin also wrapping widgets, the chain grows by 2 frames per
# prompt: after N prompts the call depth is O(2N), hitting FUNCNEST=1000 after
# ~500 prompts — or sooner when a single command triggers multiple precmd cycles.
ZSH_AUTOSUGGEST_MANUAL_REBIND=1

source "$ZIM_HOME/init.zsh"

# ── Async byte-compilation ────────────────────────────────────────────────────
# Compiles all config files to .zwc after the first prompt. zsh auto-loads the
# .zwc when it is newer than the source, saving ~10-15ms parse time per file.
# The glob qualifier (N.) restricts to existing plain files; ~*.zwc excludes
# already-compiled outputs so they are never re-compiled into themselves.
_zcompile_configs() {
  local -a targets=(
    "$ZDOTDIR"/.zshrc(N.)
    "$ZDOTDIR"/.zshenv(N.)
    "$ZDOTDIR"/.zprofile(N.)
    "$ZCONFDIR"/*.zsh(N.)
    "$ZCONFDIR"/init/*.zsh(N.)
    "$ZCONFDIR"/hooks.d/**/*.zsh(N.)
    "$ZCONFDIR"/widgets/**/^*.zsh(N.)
  )
  local f
  for f in $targets; do
    [[ ! -f ${f}.zwc || $f -nt ${f}.zwc ]] && zcompile "$f" 2>/dev/null
  done
  unfunction _zcompile_configs
}
zsh-defer _zcompile_configs
