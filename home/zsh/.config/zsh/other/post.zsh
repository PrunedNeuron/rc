# $ZCONFDIR/other/post.zsh

source ${ZIM_HOME}/init.zsh

# Compile all zsh config to wordcode (.zwc) asynchronously after prompt.
# zsh loads .zwc automatically if newer than source, saving ~10-15ms parse time.
# Glob qualifier ~*.zwc ensures compiled files are never re-compiled.
_zcompile_configs() {
  local -a targets=(
    $ZDOTDIR/.zshrc(N.)
    $ZDOTDIR/.zshenv(N.)
    $ZDOTDIR/.zprofile(N.)
    $ZCONFDIR/*.zsh(N.)
    $ZCONFDIR/other/*.zsh(N.)
    $ZCONFDIR/hooks.d/**/*.zsh(N.)
    # ~*.zwc excludes already-compiled files — prevents the .zwc.zwc cascade
    $ZCONFDIR/widgets/**/^*.zwc(.N)
  )
  local f
  for f in $targets; do
    # Skip if zwc is already up to date
    [[ ! -f ${f}.zwc || $f -nt ${f}.zwc ]] && zcompile "$f" 2>/dev/null
  done
}
# Defer by name — zsh-defer takes a command, not a function definition
zsh-defer _zcompile_configs
