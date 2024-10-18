#!/bin/sh

set -e

if [[ -d ~/.dotfiles ]]; then
    echo "Directory ~/.dotfiles already exists, skip installation"
    exit 0
fi

echo "Cloning lyubenblagoev/dotfiles into ~/.dotfiles"
git clone http://github.com/lyubenblagoev/dotfiles.git ~/.dotfiles

echo "Cloning Vundle into vim/bundle"
mkdir -p ~/.dotfiles/vim/bundle
git clone https://github.com/VundleVim/Vundle.vim.git ~/.dotfiles/vim/bundle/Vundle.vim

echo "Creating symbolic links"
if [[ -d ~/.vim ]]; then
    echo "Directory ~/.vim already exists, backing up to ~/.vim.bak"
    mv .vim ~/.vim.bak
fi
ln -s ~/.dotfiles/vim ~/.vim

if [[ -e ~/.gitconfig ]]; then
    echo "Backing up .vimrc to .vimrc.bak"
    mv .vimrc .vimrc.bak
fi
ln -s ~/.dotfiles/vimrc ~/.vimrc

if [[ -e ~/.gitconfig ]]; then
    echo "Backing up .gitconfig to .gitconfig.bak"
    mv .gitconfig .gitconfig.bak
fi
ln -s ~/.dotfiles/gitconfig ~/.gitconfig

echo "Installing Vim plugins"
vim +PluginInstall +qa!

echo "Done"
