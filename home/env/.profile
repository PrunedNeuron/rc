# ~/.profile

# systemd
export SYSTEMD_PAGER=
export SYSTEMD_URLIFY=true
export SYSTEMD_COLORS=true

# SSH socket
export SSH_AUTH_SOCK="$XDG_RUNTIME_DIR/ssh-agent.socket"

# Charset
export LANG=en_US.UTF-8
export LANGUAGE="$LANG"
export LC_ALL="$LANG"
export LC_CTYPE="$LANG"
export LC_NUMERIC="$LANG"
export LC_TIME="$LANG"
export LC_COLLATE="$LANG"
export LC_MONETARY="$LANG"
export LC_MESSAGES="$LANG"
export LC_PAPER="$LANG"
export LC_NAME="$LANG"
export LC_ADDRESS="$LANG"
export LC_TELEPHONE="$LANG"
export LC_MEASUREMENT="$LANG"
export LC_IDENTIFICATION="$LANG"

export LESSCHARSET=UTF-8

# EDITOR & VISUAL
# --
exists () { hash "$1" 2>/dev/null && echo "$1" || echo "$2" ; }

# Use neovim if installed, else fallback to nano --
export EDITOR=$(exists nvim nano)
export VISUAL=$EDITOR
export PAGER="sh -c \"col -b | nvim -c 'set ft=man ts=8 nomod nolist nonu' -c 'nnoremap i <nop>' -\""
export MANPAGER=$PAGER

# Unset function 'exists'
unset -f exists
# --

# GPG
export GPG_TTY=$(tty)

# GTK <-> KDE Portal
export GTK_USE_PORTAL=1

# Enable docker buildkit
export DOCKER_BUILDKIT=1 COMPOSE_DOCKER_CLI_BUILD=1

# Kitty IME Support
export GLFW_IM_MODULE=ibus

# Disable telemetry
export DO_NOT_TRACK=1
export NEXT_TELEMETRY_DEBUG=1
export NUXT_TELEMETRY_DISABLED=1
export GATSBY_TELEMETRY_OPT_OUT=1
export NG_CLI_ANALYTICS=false
export HINT_TELEMETRY="off"
export STRIPE_TELEMETRY_OPTOUT=1
export STRIPE_CLI_TELEMETRY_OPTOUT=1
export VAGRANT_CHECKPOINT_DISABLE=1
export POWERSHELL_TELEMETRY_OPTOUT=1
export AUTOMATEDLAB_TELEMETRY_OPTOUT='1'
export CHECKPOINT_DISABLE=1
export STNOUPGRADE=1
export HASURA_GRAPHQL_ENABLE_TELEMETRY="false"
export SAM_CLI_TELEMETRY=0
export AZURE_CORE_COLLECT_TELEMETRY=0
export HOMEBREW_NO_ANALYTICS=1
export DOTNET_CLI_TELEMETRY_OPTOUT="true"
export SCOUT_DISABLE=1
export CLICOLOR=1
