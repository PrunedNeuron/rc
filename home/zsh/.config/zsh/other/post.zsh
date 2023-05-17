# ~/.config/zsh/other/post.zsh
# Runs after zshrc

MAMBA_SCRIPT=/opt/mambaforge/etc/profile.d/conda.sh

emulate sh -c '[ -f $MAMBA_SCRIPT ] && source $MAMBA_SCRIPT'

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/opt/mambaforge/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/opt/mambaforge/etc/profile.d/conda.sh" ]; then
        . "/opt/mambaforge/etc/profile.d/conda.sh"
    else
        export PATH="/opt/mambaforge/bin:$PATH"
    fi
fi
unset __conda_setup

if [ -f "/opt/mambaforge/etc/profile.d/mamba.sh" ]; then
    . "/opt/mambaforge/etc/profile.d/mamba.sh"
fi
# <<< conda initialize <<<
