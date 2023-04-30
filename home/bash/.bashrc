# ~/.bashrc

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

source ~/.config/shell/aliases
# PS1='[\u@\h \W]\$ '

eval "$(starship init bash)"
export PATH="/home/ayush/genv/bin:$PATH"
eval "$(genv init -)"
