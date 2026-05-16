# zimfw/post.zsh — Pre-plugin variable declarations → source ZIM_HOME/init.zsh
# → schedule async byte-compilation.

# ZSH_AUTOSUGGEST_MANUAL_REBIND is intentionally NOT set here.
# Modern zsh-autosuggestions (≥ 0.7) registers _zsh_autosuggest_start as a
# self-removing precmd hook: it runs exactly once on the first prompt, binds
# widgets after all other plugins (including zsh-syntax-highlighting) have
# loaded, then removes itself. No FUNCNEST growth occurs. Setting MANUAL_REBIND
# causes widgets to be bound before ZSH_AUTOSUGGEST_USE_ASYNC is defined,
# preventing the async suggestion pty from starting and silencing all suggestions.

source "$ZIM_HOME/init.zsh"

# ── Async byte-compilation ────────────────────────────────────────────────────
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
    [[ ! -f ${f}.zwc || $f -nt ${f}.zwc ]] && zcompile "$f" 2>/dev/null
  done
  unfunction _zcompile_configs
}
zsh-defer _zcompile_configs