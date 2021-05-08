# Spaceship - denysdovhan/spaceship-prompt

#SPACESHIP_PROMPT_ADD_NEWLINE=true
SPACESHIP_PROMPT_SEPARATE_LINE=true

# Time options
#SPACESHIP_TIME_SHOW=true
SPACESHIP_TIME_12HR=true

# SPACESHIP_PROMPT_ADD_NEWLINE=false
SPACESHIP_PACKAGE_SYMBOL=📦

# USER
SPACESHIP_USER_PREFIX="" # remove `with` before username
SPACESHIP_USER_SUFFIX="" # remove space before host

# HOST
# Result will look like this:
#   username@:(hostname)
SPACESHIP_HOST_PREFIX="@:("
SPACESHIP_HOST_SUFFIX=") "

# DIR
SPACESHIP_DIR_PREFIX='' # disable directory prefix, cause it's not the first section
SPACESHIP_DIR_TRUNC='1' # show only last directory

# GIT
SPACESHIP_GIT_STATUS_SHOW=false
# Disable git symbol
SPACESHIP_GIT_SYMBOL="" # disable git prefix
SPACESHIP_GIT_BRANCH_PREFIX="" # disable branch prefix too
# Wrap git in `git:(...)`
SPACESHIP_GIT_PREFIX='git:('
SPACESHIP_GIT_SUFFIX=") "
SPACESHIP_GIT_BRANCH_SUFFIX="" # remove space after branch name
# Unwrap git status from `[...]`
SPACESHIP_GIT_STATUS_PREFIX=""
SPACESHIP_GIT_STATUS_SUFFIX=""

# NODE
SPACESHIP_NODE_PREFIX="node:("
SPACESHIP_NODE_SUFFIX=") "
SPACESHIP_NODE_SYMBOL="⬢ "

# RUBY
SPACESHIP_RUBY_PREFIX="ruby:("
SPACESHIP_RUBY_SUFFIX=") "
SPACESHIP_RUBY_SYMBOL="💎 "

# XCODE
SPACESHIP_XCODE_PREFIX="xcode:("
SPACESHIP_XCODE_SUFFIX=") "
SPACESHIP_XCODE_SYMBOL="🛠 "

# SWIFT
SPACESHIP_SWIFT_PREFIX="swift:("
SPACESHIP_SWIFT_SUFFIX=") "
SPACESHIP_SWIFT_SYMBOL="🐦 "

# GOLANG
SPACESHIP_GOLANG_PREFIX="go:("
SPACESHIP_GOLANG_SUFFIX=") "
SPACESHIP_GOLANG_SYMBOL="🐹 "

# DOCKER
SPACESHIP_DOCKER_PREFIX="docker:("
SPACESHIP_DOCKER_SUFFIX=") "
SPACESHIP_DOCKER_SYMBOL="🐳 "

# VENV
SPACESHIP_VENV_PREFIX="venv:("
SPACESHIP_VENV_SUFFIX=") "

# PYENV
SPACESHIP_PYENV_PREFIX="python:("
SPACESHIP_PYENV_SUFFIX=") "
SPACESHIP_PYENV_SYMBOL=""

# Execution time
SPACESHIP_EXEC_TIME_SHOW=true
SPACESHIP_EXEC_TIME_ELAPSED=1 # in seconds

# Exit code
SPACESHIP_EXIT_CODE_SHOW=false
SPACESHIP_EXIT_CODE_SYMBOL=✗

SPACESHIP_WIP_PREFIX="${SPACESHIP_WIP_PREFIX="$SPACESHIP_PROMPT_DEFAULT_PREFIX"}"
SPACESHIP_WIP_SUFFIX="${SPACESHIP_WIP_SUFFIX="$SPACESHIP_PROMPT_DEFAULT_SUFFIX"}"
SPACESHIP_WIP_SYMBOL="${SPACESHIP_WIP_SYMBOL="🚧 "}"
SPACESHIP_WIP_TEXT="${SPACESHIP_WIP_TEXT="WIP!!! "}"
SPACESHIP_WIP_COLOR="${SPACESHIP_WIP_COLOR="red"}"

spaceship_wip() {
  [[ $SPACESHIP_WIP_SHOW == false ]] && return

  spaceship::is_git || return
  spaceship::exists work_in_progress || return

  if [[ $(work_in_progress) == "WIP!!" ]]; then
    # Display WIP section
    spaceship::section \
      "$SPACESHIP_WIP_COLOR" \
      "$SPACESHIP_WIP_PREFIX" \
      "$SPACESHIP_WIP_SYMBOL" \
      "$SPACESHIP_WIP_TEXT" \
      "$SPACESHIP_WIP_SUFFIX"
  fi
}


# Prompt order
# Just comment/remove a section if you want to disable it
SPACESHIP_PROMPT_ORDER=(user dir host git node golang docker wip line_sep char)
SPACESHIP_RPROMPT_ORDER=(jobs exec_time exit_code)
