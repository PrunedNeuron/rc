# ~/.bash_profile
[ -f ~/.profile ] && source ~/.profile

[ -f ~/.pathrc ] && source ~/.pathrc
export PATH=$(IFS=$':'; echo "${paths[*]}")

[ -f ~/.bashrc ] && source ~/.bashrc
