# ~/.config/zsh/other/post.zsh
# Runs after zshrc

# Fig post block. Keep at the bottom of this file.
# [[ -f "$HOME/.fig/shell/zshrc.post.zsh" ]] && . "$HOME/.fig/shell/zshrc.post.zsh"

# pyenv
export PYENV_ROOT="$HOME/.pyenv"
command -v pyenv >/dev/null || export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init -)"


export PATH="/home/ayush/.deta/bin:$PATH"

CONDA_PATH='/opt/mambaforge/etc/profile.d/conda.sh'

emulate sh -c \
    '[ -f "$CONDA_PATH" ] \
    && source "$CONDA_PATH"'

