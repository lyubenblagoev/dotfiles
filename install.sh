#!/bin/sh

set -e

echo "Cloning lyubenblagoev/dotfiles into ~/.dotfiles"
git clone http://github.com/lyubenblagoev/dotfiles.git ~/.dotfiles

echo "Cloning Vundle into vim/bundle"
mkdir -p ~/.dotfiles/vim/bundle
git clone https://github.com/VundleVim/Vundle.vim.git ~/.dotfiles/vim/bundle/Vundle.vim

echo "Creating symbolic links"
ln -s ~/.dotfiles/vim ~/.vim
ln -s ~/.dotfiles/vimrc ~/.vimrc
ln -s ~/.dotfiles/gitconfig ~/.gitconfig

echo "Installing Vim plugins"
vim +PluginInstall +qa!

echo "Done"
