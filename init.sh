#!/bin/bash
set -o errexit
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

# Git
mkdir -p $HOME/.config
rm -r $HOME/.config/git &> /dev/null
ln -s $(pwd)/git $HOME/.config/git

# Neovim
rm -r $HOME/.config/nvim &> /dev/null
rm -r $HOME/.config/coc/ultisnips &> /dev/null
ln -s $(pwd)/nvim $HOME/.config/nvim
ln -s $(pwd)/nvim/snips $HOME/.config/coc/ultisnips

# tmux
rm $HOME/.tmux.conf &> /dev/null
ln -s $(pwd)/.tmux.conf $HOME/.tmux.conf
