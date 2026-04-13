# ~/.profile — POSIX sh; sourced by login shells via .zprofile.

# ── Systemd ───────────────────────────────────────────────────────────────────
export SYSTEMD_PAGER=''
export SYSTEMD_URLIFY=true
export SYSTEMD_COLORS=true

# ── SSH / GPG ─────────────────────────────────────────────────────────────────
export SSH_AUTH_SOCK="$HOME/.1password/agent.sock"
export GPG_TTY=$(tty)
export PINENTRY_KDE_USE_WALLET=1

# ── Locale — full POSIX set ───────────────────────────────────────────────────
export LANG=en_US.UTF-8
export LANGUAGE="$LANG"
for _lc in ALL CTYPE NUMERIC TIME COLLATE MONETARY MESSAGES PAPER \
           NAME ADDRESS TELEPHONE MEASUREMENT IDENTIFICATION; do
  export "LC_${_lc}=${LANG}"
done; unset _lc
export LESSCHARSET=UTF-8

# ── Editor & Pager ────────────────────────────────────────────────────────────
if command -v nvim &>/dev/null; then
  export EDITOR=nvim VISUAL=nvim
  # nvim's built-in :Man! plugin — full navigation, syntax highlighting, search
  export MANPAGER='nvim +Man!'
  export MANWIDTH=999
else
  export EDITOR=nano VISUAL=nano
  command -v bat &>/dev/null \
    && export MANPAGER="sh -c 'col -bx | bat -l man -p'"
fi

# ── less ──────────────────────────────────────────────────────────────────────
# -F  quit if output fits on screen     -R  pass raw ANSI colours through
# -X  no clear-screen on exit           -M  verbose prompt with line/percent
# -i  case-insensitive search           -W  highlight first unread line after jump
# --mouse  scroll wheel support (less ≥ 590)
export LESS='-FRXMiW --mouse'
export PAGER='less'
# Route any file through bat for syntax highlighting inside less
command -v bat &>/dev/null \
  && export LESSOPEN="| bat --color=always --style=plain %s 2>/dev/null"

# ── Colours ───────────────────────────────────────────────────────────────────
export CLICOLOR=1
export GREP_COLORS='ms=01;31:mc=01;31:sl=:cx=:fn=35:ln=32:bn=32:se=36'

# ── Wayland / GTK / Qt ───────────────────────────────────────────────────────
export MOZ_ENABLE_WAYLAND=1
export MOZ_USE_XINPUT2=1
export GLFW_IM_MODULE=ibus
export GTK_USE_PORTAL=1
export QT_AUTO_SCREEN_SCALE_FACTOR=1
export QT_ENABLE_HIGHDPI_SCALING=1

# ── Docker ────────────────────────────────────────────────────────────────────
export DOCKER_HOST=''

# ── Telemetry opt-out ─────────────────────────────────────────────────────────
export DO_NOT_TRACK=1
export NEXT_TELEMETRY_DEBUG=1
export NUXT_TELEMETRY_DISABLED=1
export GATSBY_TELEMETRY_OPT_OUT=1
export NG_CLI_ANALYTICS=false
export HINT_TELEMETRY=off
export STRIPE_TELEMETRY_OPTOUT=1
export STRIPE_CLI_TELEMETRY_OPTOUT=1
export VAGRANT_CHECKPOINT_DISABLE=1
export POWERSHELL_TELEMETRY_OPTOUT=1
export AUTOMATEDLAB_TELEMETRY_OPTOUT=1
export CHECKPOINT_DISABLE=1
export STNOUPGRADE=1
export HASURA_GRAPHQL_ENABLE_TELEMETRY=false
export SAM_CLI_TELEMETRY=0
export AZURE_CORE_COLLECT_TELEMETRY=0
export HOMEBREW_NO_ANALYTICS=1
export DOTNET_CLI_TELEMETRY_OPTOUT=true
export SCOUT_DISABLE=1
