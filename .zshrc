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
alias dcattach='docker container attach'
alias dcexec='docker container exec -it'
alias dcls='docker container ls -a'
alias dcprune='docker container prune -f'
alias dcrun='docker container run -it --rm'
alias dcstop='docker container stop'

alias dibuild='docker image build'
alias dils='docker image ls'

alias dninspect='docker network inspect'
alias dnls='docker network ls'

alias d-c='docker-compose'

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
fpath+=($HOME/.zsh/pure)
autoload -U promptinit; promptinit
prompt pure

zstyle :prompt:pure:path color cyan
zstyle :prompt:pure:prompt:success color green

# zsh-autosuggestions
if ! [[ -d ~/.zsh/zsh-autosuggestions ]]; then
  git clone https://github.com/zsh-users/zsh-autosuggestions ~/.zsh/zsh-autosuggestions
fi
source ~/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh

# wsl
# See https://stackoverflow.com/questions/38086185/how-to-check-if-a-program-is-run-in-bash-on-ubuntu-on-windows-and-not-just-plain
if [ -n "$WSL_DISTRO_NAME" ]; then
  # commands for wsl
fi

# other
alias yyyymmdd='date "+%Y%m%d"'
if [ -x "$(command -v colordiff)" ]; then
  alias diff='colordiff'
fi
