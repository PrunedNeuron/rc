# $ZCONFDIR/init/post.zsh
# init zim; async byte-compile configs.

source "$ZIM_HOME/init.zsh"

# Byte-compile all config files asynchronously after first prompt.
# zsh auto-loads .zwc when newer than source — saves ~10-15ms parse time/file.
# ~*.zwc glob qualifier prevents compiled files being re-compiled.
_zcompile_configs() {
  local -a targets=(
    "$ZDOTDIR"/.zshrc(N.)
    "$ZDOTDIR"/.zshenv(N.)
    "$ZDOTDIR"/.zprofile(N.)
    "$ZCONFDIR"/*.zsh(N.)
    "$ZCONFDIR"/init/*.zsh(N.)
    "$ZCONFDIR"/hooks.d/**/*.zsh(N.)
    "$ZCONFDIR"/widgets/**/^*.zwc(.N)
  )
  local f
  for f in $targets; do
    [[ ! -f ${f}.zwc || $f -nt ${f}.zwc ]] && zcompile "$f" 2>/dev/null
  done
  unfunction _zcompile_configs
}

zsh-defer _zcompile_configs
