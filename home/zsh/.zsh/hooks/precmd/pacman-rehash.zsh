# Pacman cache rehash precmd hook | source: https://wiki.archlinux.org/title/Zsh

zshcache_time="$(date +%s%N)"

pacman_rehash_precmd() {
  if [[ -a /var/cache/zsh/pacman ]]; then
    local paccache_time="$(date -r /var/cache/zsh/pacman +%s%N)"
    if (( zshcache_time < paccache_time )); then
      rehash
      zshcache_time="$paccache_time"
    fi
  fi
}

precmd_functions+=(pacman_rehash_precmd)
