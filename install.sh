#!/bin/sh

set -e

if [[ -d ~/.dotfiles ]]; then
    echo "Directory ~/.dotfiles already exists, skip installation"
    exit 0
fi

echo "Cloning lyubenblagoev/dotfiles into ~/.dotfiles"
git clone https://github.com/lyubenblagoev/dotfiles.git ~/.dotfiles

if ! grep -i .dotfiles\/config\/bash\/environment ~/.bashrc > /dev/null; then
    sed -i "$ a [ -r ~/.dotfiles/config/bash/environment ] && . ~/.dotfiles/config/bash/environment" ~/.bashrc
fi

echo "Cloning Vundle into vim/bundle"
mkdir -p ~/.dotfiles/config/local/vim/bundle
git clone https://github.com/VundleVim/Vundle.vim.git ~/.dotfiles/config/local/vim/bundle/Vundle.vim

echo "Creating symbolic links"

if [[ -d ~/.vim ]]; then
    echo "Directory ~/.vim already exists, backing up to ~/.vim.bak"
    mv ~/.vim ~/.vim.bak
elif [[ -L ~/.vim ]]; then
    rm ~/.vim
fi
ln -s ~/.dotfiles/config/local/vim ~/.vim

if [[ -e ~/.vimrc ]]; then
    echo "Backing up .vimrc to .vimrc.bak"
    mv ~/.vimrc ~/.vimrc.bak
elif [[ -L ~/.vimrc ]]; then
    rm ~/.vimrc
fi
ln -s ~/.dotfiles/config/vim/vimrc ~/.vimrc

if [[ -e ~/.gitconfig ]]; then
    echo "Backing up .gitconfig to .gitconfig.bak"
    mv ~/.gitconfig ~/.gitconfig.bak
elif [[ -L ~/.gitconfig ]]; then
    rm ~/.gitconfig
fi
ln -s ~/.dotfiles/config/git/gitconfig ~/.gitconfig

echo "Installing Vim plugins"
vim +PluginInstall +qa!

echo "Done"
