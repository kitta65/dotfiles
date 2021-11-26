#!/bin/bash
cd $(dirname $0)

#ln -s $(pwd)/dotfiles/zsh/.zshrc $HOME/.zshrc
#ln -s $(pwd)/dotfiles/zsh/.zprofile $HOME/.zprofile

# Git
mkdir -p $HOME/.config
rm -r $HOME/.config/git &> /dev/null
ln -s $(pwd)/git $HOME/.config/git

# Neovim
rm -r $HOME/.config/nvim &> /dev/null
rm -r $HOME/.config/coc/ultisnips &> /dev/null
ln -s $(pwd)/nvim $HOME/.config/nvim
ln -s $(pwd)/nvim/snips $HOME/.config/coc/ultisnips
