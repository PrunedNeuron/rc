# ~/.zsh/preinit.zsh
# Runs before compinit

# Install zinit if not installed
if [[ ! -f $HOME/.zinit/bin/zinit.zsh ]]; then
    local CYAN='\033[0;36m'
    local GREEN="\e[32m"
    local LIGHTRED='\033[1;31m'
    local NOCOLOR="\e[0m"
    print -P "Installing ${CYAN}zinit${NOCOLOR}."
    command mkdir -p "$HOME/.zinit" && command chmod g-rwX "$HOME/.zinit"
    command git clone https://github.com/zdharma/zinit "$HOME/.zinit/bin" && \\
        print -P "${GREEN}Installation successful.${NOCOLOR}" || \\
        print -P "${RED}Installation failed.${NOCOLOR}"
fi

# Initialize zinit
source "$HOME/.zinit/bin/zinit.zsh"
