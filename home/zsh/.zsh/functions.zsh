mkcdir() {
    mkdir -p -- "$1" && cd -P -- "$1"
}

reloadde() {

    setsid kwin_x11 --replace &
    setsid plasmashell --replace &

}

refreshmirrors() {

	sudo reflector --latest 200 --protocol https --sort rate --fastest 50 --save /etc/pacman.d/mirrorlist
	
}

reloaddns() {

	sudo systemctl restart dnscrypt-proxy
	sudo systemctl restart pihole-FTL
	sudo systemctl restart NetworkManager

}

reloadpi() {

	sudo systemctl restart pihole-FTL

}

reloadnm() {

	sudo systemctl restart NetworkManager

}

dnscrypt-status() {

	sudo systemctl status dnscrypt-proxy

}

updatepi() {

	sudo pihole -g
	xargs -l pihole -w < /etc/pihole/whitelist.txt

} 

lazynvm() {
  unset -f nvm node npm npx
  export NVM_DIR=~/.nvm
  [ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh" # This loads nvm
  if [ -f "$NVM_DIR/bash_completion" ]; then
    [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion" # This loads nvm bash_completion
  fi
}

nvm() {
  lazynvm 
  nvm $@
}
 
node() {
  lazynvm
  node $@
}
 
npm() {
  lazynvm
  npm $@
}

npx() {
  lazynvm
  npx $@
}

clean-k8s() {
	kubectl delete "$(kubectl api-resources --namespaced=true --verbs=delete -o name | tr "\n" "," | sed -e 's/,$//')" --all
}

command_not_found_handler() {
	local pkgs cmd="$1" files=()
	printf 'zsh: command not found: %s' "$cmd" # print command not found asap, then search for packages
	files=(${(f)"$(pacman -F --machinereadable -- "/usr/bin/${cmd}")"})
	if (( ${#files[@]} )); then
		printf '\r%s may be found in the following packages:\n' "$cmd"
		local res=() repo package version file
		for file in "$files[@]"; do
			res=("${(0)file}")
			repo="$res[1]"
			package="$res[2]"
			version="$res[3]"
			file="$res[4]"
			printf '  %s/%s %s: /%s\n' "$repo" "$package" "$version" "$file"
		done
	else
		printf '\n'
	fi
	return 127
}

man() {
    env \
        LESS_TERMCAP_mb=$(printf "\e[1;31m") \
        LESS_TERMCAP_md=$(printf "\e[1;31m") \
        LESS_TERMCAP_me=$(printf "\e[0m") \
        LESS_TERMCAP_se=$(printf "\e[0m") \
        LESS_TERMCAP_so=$(printf "\e[1;44;33m") \
        LESS_TERMCAP_ue=$(printf "\e[0m") \
        LESS_TERMCAP_us=$(printf "\e[1;32m") \
            man "$@"
}
