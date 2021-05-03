# ~/.bashrc

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

source ~/.aliasrc
PS1='[\u@\h \W]\$ '
