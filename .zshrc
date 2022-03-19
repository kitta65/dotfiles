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
    -p 8787:8787 \
    -v $HOME/.renv:/renv \
    -v $(pwd):/home/rstudio/project \
    -v $DOTFILES_DIR/rstudio-prefs.json:/home/rstudio/.config/rstudio/rstudio-prefs.json \
    rocker/verse:4.1.2'

# wsl
# See https://stackoverflow.com/questions/38086185/how-to-check-if-a-program-is-run-in-bash-on-ubuntu-on-windows-and-not-just-plain
if [ -n "$WSL_DISTRO_NAME" ]; then
  # in the case of `appendWindowsPath = false`
  export PATH=$PATH:/mnt/c/WINDOWS/system32
  export PATH=$PATH:/mnt/c/WINDOWS/System32/WindowsPowerShell/v1.0

  function setWinUser() {
    # It is not a good idea to run `powershell.exe` every time.
    # It will take a lot of time.
    if ! [ -v WINUSER ]; then
      export WINUSER=$(powershell.exe '$env:UserName' | tr -d "\r")
    fi
  }

  alias code='setWinUser;/mnt/c/Users/$WINUSER/AppData/Local/Programs/Microsoft\ VS\ Code/bin/code'
fi

# other
alias yyyymmdd='date "+%Y%m%d"'
