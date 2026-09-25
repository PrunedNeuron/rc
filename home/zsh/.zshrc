# ~/.zshrc — Interactive shell entry point.

# Keep this file declarative. Startup logic belongs in dedicated modules.
#
# Load order:
#   1. session bootstrap
#   2. Zim bootstrap
#   3. core shell configuration
#   4. static tool environment
#   5. completion + fzf policy
#   6. Zim/plugins
#   7. post-plugin tool integration
#   8. hooks/widgets/keybindings
#   9. micromamba

source "$ZCONFDIR/core/session.zsh"

source "$ZCONFDIR/zimfw/bootstrap.zsh"

source "$ZCONFDIR/core/modules.zsh"
source "$ZCONFDIR/core/history.zsh"
source "$ZCONFDIR/core/options.zsh"
source "$ZCONFDIR/functions.zsh"

source "$ZCONFDIR/tools/env.zsh"

source "$ZCONFDIR/core/completion.zsh"

source "$ZCONFDIR/fzf/defaults.zsh"
source "$ZCONFDIR/fzf/commands.zsh"
source "$ZCONFDIR/fzf/tab.zsh"

source "$ZCONFDIR/zimfw/post.zsh"

source "$ZCONFDIR/tools/async.zsh"

source "$ZCONFDIR/hooks/hooks.zsh"
source "$ZCONFDIR/core/widgets.zsh"

source "$ZCONFDIR/keybindings.zsh"

source "$ZCONFDIR/tools/micromamba.zsh"
