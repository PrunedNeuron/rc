# SSH socket
export SSH_AUTH_SOCK="$XDG_RUNTIME_DIR/ssh-agent.socket"

# Locale
export LANG=en_US.UTF-8
export LC_ALL=$LANG
export LANGUAGE=$LANG

# Editor
export EDITOR=nano
export VISUAL=$EDITOR

# GPG
export GPG_TTY=$(tty)

# Use KDE file selector dialog instead of GTK
export GTK_USE_PORTAL=1

# Enable docker buildkit
export DOCKER_BUILDKIT=1 COMPOSE_DOCKER_CLI_BUILD=1
