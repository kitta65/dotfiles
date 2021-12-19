if [ -v DOTFILE_ENABLED ]; then
  exit 0
fi
export DOTFILE_ENABLED=1

# tmux
export TERM=xterm-256color
