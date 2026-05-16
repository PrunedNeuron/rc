# widgets/docker.zsh — Docker management hub. Alt+O.
#
# Container browser: Ctrl+S start  Ctrl+T stop   Ctrl+K kill  Ctrl+R restart
#                    Ctrl+L logs   Ctrl+E exec shell  Enter attach
# Image browser:     Ctrl+R run shell  Ctrl+D delete
# Volume browser:    Ctrl+D delete     Ctrl+/ inspect

# FIX: keep as typeset -g so the functions that reference it by variable name
# at call time (not definition time) can still expand it after file source.
typeset -g _docker_inspect_preview='
  id={1}
  docker inspect "$id" 2>/dev/null \
    | bat --language=json --color=always --style=plain | head -60 \
  || docker image inspect "$id" 2>/dev/null \
    | bat --language=json --color=always --style=plain | head -60
'

_fzf_docker_containers() {
  local _fmt='table {{.ID}}\t{{.Names}}\t{{.Image}}\t{{.Status}}\t{{.Ports}}'
  docker ps -a --format "$_fmt" 2>/dev/null | tail -n +2 \
  | fzf \
      --multi \
      --prompt='container ❯ ' \
      --input-label=' Containers ' \
      --header='  Ctrl+S: start  Ctrl+T: stop  Ctrl+K: kill  Ctrl+R: restart  Ctrl+L: logs  Ctrl+E: shell' \
      --header-border=bottom \
      --bind="load:transform-footer:echo ' \$FZF_TOTAL_COUNT containers'" \
      --footer-border=top \
      --preview="$_docker_inspect_preview" \
      --preview-window='right:55%:border-rounded:wrap' \
      --bind='ctrl-/:toggle-preview' \
      --bind="ctrl-s:execute-silent(docker start   {1} 2>/dev/null)+reload(docker ps -a --format '$_fmt' | tail -n +2)+refresh-preview" \
      --bind="ctrl-t:execute-silent(docker stop    {1} 2>/dev/null)+reload(docker ps -a --format '$_fmt' | tail -n +2)+refresh-preview" \
      --bind="ctrl-k:execute-silent(docker kill    {1} 2>/dev/null)+reload(docker ps -a --format '$_fmt' | tail -n +2)+refresh-preview" \
      --bind="ctrl-r:execute-silent(docker restart {1} 2>/dev/null)+reload(docker ps -a --format '$_fmt' | tail -n +2)+refresh-preview" \
      --bind='ctrl-l:execute(docker logs -f {1} </dev/tty >/dev/tty 2>&1)' \
      --bind='ctrl-e:execute(docker exec -it {1} sh </dev/tty >/dev/tty 2>&1)' \
      --bind='enter:execute(docker attach {1} </dev/tty >/dev/tty 2>&1)'
}

_fzf_docker_images() {
  local _fmt='table {{.Repository}}\t{{.Tag}}\t{{.ID}}\t{{.Size}}\t{{.CreatedSince}}'
  docker images --format "$_fmt" 2>/dev/null | tail -n +2 \
  | fzf \
      --multi \
      --prompt='image ❯ ' \
      --input-label=' Images ' \
      --header='  Ctrl+R: run shell  Ctrl+D: delete' \
      --header-border=bottom \
      --bind="load:transform-footer:echo ' \$FZF_TOTAL_COUNT images'" \
      --footer-border=top \
      --preview="$_docker_inspect_preview" \
      --preview-window='right:55%:border-rounded:wrap' \
      --bind='ctrl-/:toggle-preview' \
      --bind='ctrl-r:execute(docker run -it --rm {3} sh </dev/tty >/dev/tty 2>&1)' \
      --bind="ctrl-d:execute-silent(docker rmi {3} 2>/dev/null)+reload(docker images --format '$_fmt' | tail -n +2)"
}

_fzf_docker_volumes() {
  docker volume ls --format 'table {{.Driver}}\t{{.Name}}' 2>/dev/null \
  | tail -n +2 \
  | fzf \
      --multi \
      --prompt='volume ❯ ' \
      --input-label=' Volumes ' \
      --header='  Ctrl+D: delete  Ctrl+/: inspect' \
      --header-border=bottom \
      --preview='docker volume inspect {2} 2>/dev/null | bat --language=json --color=always --style=plain' \
      --preview-window='right:55%:border-rounded:wrap' \
      --bind='ctrl-/:toggle-preview' \
      --bind="ctrl-d:execute-silent(docker volume rm {2} 2>/dev/null)+reload(docker volume ls --format 'table {{.Driver}}\t{{.Name}}' | tail -n +2)"
}

_fzf_docker_hub() {
  command -v docker &>/dev/null || { zle -M '✗ docker not found.'; zle reset-prompt; return }

  local choice
  choice=$(
    printf '%s\n' \
      'containers  browse all; start/stop/exec/attach' \
      'images      browse local images; run/delete' \
      'volumes     browse volumes; inspect/delete' \
      'prune       remove stopped containers, unused images & volumes' \
    | fzf \
        --prompt='docker ❯ ' \
        --height=35% \
        --min-height=8 \
        --layout=reverse \
        --border=rounded \
        --no-preview \
        --header='  Docker Hub'
  )
  [[ -z $choice ]] && { zle reset-prompt; return }

  case ${choice%%[[:space:]]*} in
    containers) _fzf_docker_containers ;;
    images)     _fzf_docker_images     ;;
    volumes)    _fzf_docker_volumes    ;;
    prune)
      print -nP '%F{red}Remove stopped containers, dangling images, unused volumes? [y/N] %f'
      local _c; read -r _c
      [[ ${_c:l} == y ]] && docker system prune -f --volumes
      ;;
  esac
  zle reset-prompt
}

zle -N _fzf_docker_hub
bindkey -M emacs '^[o' _fzf_docker_hub
bindkey -M viins '^[o' _fzf_docker_hub
bindkey -M vicmd '^[o' _fzf_docker_hub