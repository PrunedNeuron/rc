# ~/.zshrc — interactive shell only

# Bootstrap zimfw, rebuild init.zsh when .zimrc changes
source $ZCONFDIR/other/pre.zsh

# History variables (HISTFILE, HISTSIZE, SAVEHIST)
source $ZCONFDIR/other/history.zsh

# Shared POSIX/bash config (aliases, exports, PATH extensions)
for _f in $CONFDIR/shell/**/*(.N); do emulate bash -c "source $_f"; done; unset _f

# Built-in zsh modules — zsh/complist must load before compinit (post.zsh)
source $ZCONFDIR/zmods.zsh

# Shell behaviour options
source $ZCONFDIR/options.zsh

# Completion and plugin zstyles — before compinit in post.zsh
source $ZCONFDIR/styles.zsh

# Autoloaded functions
source $ZCONFDIR/functions.zsh

# precmd/preexec hooks
source $ZCONFDIR/hooks.zsh

# Initialize all zimfw modules — this is where zsh-defer becomes available
source $ZCONFDIR/other/post.zsh

# External tools: starship (sync), zoxide + atuin (async via zsh-defer)
source $ZCONFDIR/plugins.zsh

# Keybindings — unconditionally last so our binds win over every plugin
source $ZCONFDIR/keybindings.zsh
