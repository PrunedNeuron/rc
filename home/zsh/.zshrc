# ~/.zshrc — interactive shell entry point.
#
# Load order:
#   init/pre.zsh      zimfw bootstrap
#   init/history.zsh  HISTFILE / HISTSIZE / SAVEHIST
#   shell/**/*        POSIX aliases, exports, PATH extensions
#   zmods.zsh         zsh built-in modules (before compinit)
#   options.zsh       setopt flags
#   styles.zsh        zstyle completion + fzf-tab (before compinit)
#   functions.zsh     autoload custom functions + fpath
#   hooks.zsh         precmd/preexec hook registration
#   init/post.zsh     source ZIM_HOME/init.zsh; async compile; zsh-defer available
#   plugins.zsh       tool config + deferred init (starship, zoxide, atuin)
#   keybindings.zsh   all key bindings (always last)

source "$ZCONFDIR/init/pre.zsh"
source "$ZCONFDIR/init/history.zsh"

for _f in "$XDG_CONFIG_HOME/shell"/**/*(.N); do emulate bash -c "source $_f"; done
unset _f

source "$ZCONFDIR/zmods.zsh"
source "$ZCONFDIR/options.zsh"
source "$ZCONFDIR/styles.zsh"
source "$ZCONFDIR/functions.zsh"
source "$ZCONFDIR/hooks.zsh"
source "$ZCONFDIR/init/post.zsh"
source "$ZCONFDIR/plugins.zsh"
source "$ZCONFDIR/keybindings.zsh"
