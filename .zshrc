setopt histignorealldups
bindkey -e
bindkey '^]' forward-word # complete one word

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

# exa
if [ -x "$(command -v exa)" ]; then
  export EXA_COLORS="da=1;35"
  alias ll='exa -lha'
  alias tree='exa -T'
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
fpath+=$HOME/.zsh/pure
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
  # in the case of `appendWindowsPath = false`
  export PATH=$PATH:/mnt/c/WINDOWS/System32
  export PATH=$PATH:/mnt/c/WINDOWS/System32/WindowsPowerShell/v1.0

  function setWinUserProfile() {
    # It is not a good idea to run `wslvar` every time.
    # It will take a lot of time.
    if ! [ -v WINUSER_PROFILE ]; then
      export WINUSER_PROFILE=$(wslpath "$(wslvar USERPROFILE)")
    fi
  }

  alias code='setWinUserProfile;$WINUSER_PROFILE/AppData/Local/Programs/Microsoft\ VS\ Code/bin/code'
fi

# other
alias yyyymmdd='date "+%Y%m%d"'
