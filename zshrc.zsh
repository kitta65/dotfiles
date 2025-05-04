# shellcheck disable=SC2148

# NOTE
# This script is run by zsh but lint as bash script.

# Yor .zshrc should contain recommended settings.
# If not, this command is useful.
# autoload -U zsh-newuser-install; zsh-newuser-install -f
setopt HIST_IGNORE_DUPS

bindkey '^]' forward-word # complete one word

# https://stackoverflow.com/questions/444951/zsh-stop-backward-kill-word-on-directory-delimiter/11200998#11200998
export WORDCHARS=${WORDCHARS/\//}

# bat
if [ -x "$(command -v batcat)" ]; then
  alias cat='batcat'
elif [ -x "$(command -v bat)" ]; then
  alias cat='cat'
fi

# docker
alias dc='docker container'
alias di='docker image'
alias dn='docker network'

if [ -x "$(command -v docker-compose)" ]; then
  alias d-c="docker-compose"
else
  alias d-c='docker compose'
fi

alias kg='kubectl get'
alias ka='kubectl apply'
alias kd='kubectl describe'

# eza
if [ -x "$(command -v eza)" ]; then
  export EXA_COLORS="da=1;35"
  alias ll='eza --long --all'
  alias tree='eza --tree'
else
  echo 'you can install eza. see https://github.com/eza-community/eza/blob/main/INSTALL.md' >&2
  alias ll='ls -lha'
fi

# nvim
if [ -x "$(command -v nvim)" ]; then
  export EDITOR=nvim
  alias v='nvim'
elif [ -x "$(command -v vim)" ]; then
  export EDITOR=vim
  alias v='vim'
else
  export EDITOR=vi
  alias v='vi'
fi

# R
alias rstudio='\
  docker container run \
    --rm \
    -e DISABLE_AUTH=true \
    -e RENV_PATHS_CACHE=/renv \
    -p 127.0.0.1:8787:8787 \
    -v $HOME/.renv:/renv \
    -v $(pwd):/home/rstudio/project \
    -v $DOTFILES_DIR/rstudio-prefs.json:/home/rstudio/.config/rstudio/rstudio-prefs.json \
    rocker/verse:4.1.2'

# pure
if ! [[ -d ~/.zsh/pure ]]; then
  git clone https://github.com/sindresorhus/pure.git "$HOME/.zsh/pure"
fi
fpath+=("$HOME/.zsh/pure")
autoload -U promptinit
promptinit
prompt pure

zstyle :prompt:pure:path color cyan
zstyle :prompt:pure:prompt:success color green

# zsh-autosuggestions
if ! [[ -d ~/.zsh/zsh-autosuggestions ]]; then
  git clone https://github.com/zsh-users/zsh-autosuggestions ~/.zsh/zsh-autosuggestions
fi
# shellcheck disable=SC1091
source "$HOME/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh"

# other
alias yyyymmdd='date "+%Y%m%d"'
if [ -x "$(command -v colordiff)" ]; then
  alias diff='colordiff'
fi
