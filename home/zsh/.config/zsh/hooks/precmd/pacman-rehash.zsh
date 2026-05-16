# hooks/precmd/pacman-rehash.zsh — Rehash PATH when pacman updates its cache.
# Uses zstat (zsh/stat) — zero external forks.
# Source: https://wiki.archlinux.org/title/Zsh#On-demand_rehash

typeset -gF _zshcache_time=0.0

_pacman_rehash_precmd() {
  local _cache=/var/cache/zsh/pacman
  [[ -e $_cache ]] || return 0
  local -A _st
  zstat -H _st "$_cache" 2>/dev/null || return 0
  if (( _zshcache_time < _st[mtime] )); then
    rehash
    _zshcache_time=$_st[mtime]
  fi
}

precmd_functions+=(_pacman_rehash_precmd)