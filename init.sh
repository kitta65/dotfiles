#!/bin/bash
set -euo pipefail
cd $(dirname $0)

dotfile_comment='# Added by dotfiles/init.sh'

function initialize_file() {
  if [ "$(uname)" == 'Darwin' ]; then
    gsed --in-place "\%${dotfile_comment}%d" $1
  else
    sed --in-place "\%${dotfile_comment}%d" $1
  fi
}

# zsh
initialize_file $HOME/.zshrc
echo "source $(pwd)/.zshrc ${dotfile_comment}" >> $HOME/.zshrc
echo "export DOTFILES_DIR=$(pwd) ${dotfile_comment}" >> $HOME/.zshrc

# Git
mkdir -p $HOME/.config/git
rm -r $HOME/.config/git &> /dev/null
ln -s $(pwd)/git $HOME/.config/git

# Neovim
mkdir -p $HOME/.config/nvim
rm -r $HOME/.config/nvim &> /dev/null
rm -r $HOME/.config/coc/ultisnips &> /dev/null
ln -s $(pwd)/nvim $HOME/.config/nvim
ln -s $(pwd)/nvim/snips $HOME/.config/coc/ultisnips

# tmux
rm $HOME/.tmux.conf &> /dev/null
ln -s $(pwd)/.tmux.conf $HOME/.tmux.conf

# wsl
if [[ -n "$WSL_DISTRO_NAME" ]]; then
  winuser=$(/mnt/c/WINDOWS/System32/WindowsPowerShell/v1.0/powershell.exe '$env:UserName' | tr -d "\r")
  if [[ -w /etc/wsl.conf ]]; then
    cp $(pwd)/wsl/wsl.conf /etc/wsl.conf
  else
    echo "Skip replacing /etc/wsl.conf because you do not have write permission."
  fi
  cp $(pwd)/wsl/.wslconfig /mnt/c/Users/$winuser/.wslconfig
fi
