# Rehash PATH when pacman installs or removes a package.
# Uses zstat (zsh/stat) + $EPOCHREALTIME (zsh/datetime) — zero external forks.
# Source: https://wiki.archlinux.org/title/Zsh#On-demand_rehash

typeset -gF _zshcache_time=0.0

pacman_rehash_precmd() {
  local _cache=/var/cache/zsh/pacman
  [[ -e $_cache ]] || return 0
  local -A _st
  zstat -H _st "$_cache" 2>/dev/null || return 0
  if (( _zshcache_time < _st[mtime] )); then
    rehash
    _zshcache_time=$_st[mtime]
  fi
}

precmd_functions+=(pacman_rehash_precmd)
