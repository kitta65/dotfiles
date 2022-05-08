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
mkdir -p $HOME/.config
rm $HOME/.config/git 2> /dev/null || true
ln -s $(pwd)/git $HOME/.config/git

# Neovim
mkdir -p $HOME/.config/coc
rm $HOME/.config/nvim 2> /dev/null || true
rm $HOME/.config/coc/ultisnips 2> /dev/null || true
ln -s $(pwd)/nvim $HOME/.config/nvim
ln -s $(pwd)/nvim/snips $HOME/.config/coc/ultisnips

# tmux
rm $HOME/.tmux.conf 2> /dev/null || true
ln -s $(pwd)/.tmux.conf $HOME/.tmux.conf

# wsl
if [[ -v WSL_DISTRO_NAME ]]; then
  if [[ -w /etc/wsl.conf ]]; then
    cp $(pwd)/wsl/wsl.conf /etc/wsl.conf
  else
    echo "Skip replacing /etc/wsl.conf because you do not have write permission."
  fi
  # See https://superuser.com/questions/1271205/how-to-get-the-host-user-home-directory-in-wsl-bash
  cp $(pwd)/wsl/.wslconfig $(wslpath "$(wslvar USERPROFILE)")/.wslconfig
fi
