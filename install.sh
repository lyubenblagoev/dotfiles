#!/bin/bash

set -e

if [[ -d ~/.dotfiles ]]; then
    echo "==> ~/.dotfiles already exists, update and reinstall"
    rm -rf ~/.dotfiles/config/local
    cd ~/.dotfiles
    git pull origin master
    cd -
else
    echo "==> Cloning lyubenblagoev/dotfiles into ~/.dotfiles"
    git clone https://github.com/lyubenblagoev/dotfiles.git ~/.dotfiles
fi

if ! grep -i .dotfiles\/config\/bash\/environment ~/.bashrc > /dev/null; then
    echo "==> Setting-up Bash environment"
    sed -i "$ a [ -r ~/.dotfiles/config/bash/environment ] && . ~/.dotfiles/config/bash/environment" ~/.bashrc
fi

echo "==> Cloning Vundle into vim/bundle"
mkdir -p ~/.dotfiles/config/local/vim/bundle
git clone https://github.com/VundleVim/Vundle.vim.git ~/.dotfiles/config/local/vim/bundle/Vundle.vim

echo "==> Creating symbolic links"

# .vim directory symlink
if [[ -d ~/.vim ]]; then
    echo " |-- ~/.vim has been renamed to ~/.vim.bak"
    mv ~/.vim ~/.vim.bak
elif [[ -L ~/.vim ]]; then
    rm ~/.vim
fi
ln -s ~/.dotfiles/config/local/vim ~/.vim

# .vimrc symlink
if [[ -e ~/.vimrc ]]; then
    echo " |-- ~/.vimrc has been renamed to .vimrc.bak"
    mv ~/.vimrc ~/.vimrc.bak
elif [[ -L ~/.vimrc ]]; then
    rm ~/.vimrc
fi
ln -s ~/.dotfiles/config/vim/vimrc ~/.vimrc

# .gitconfig symlink
if [[ -e ~/.gitconfig ]]; then
    echo " |-- ~/.gitconifg has been renamed to .gitconfig.bak"
    mv ~/.gitconfig ~/.gitconfig.bak
elif [[ -L ~/.gitconfig ]]; then
    rm ~/.gitconfig
fi
ln -s ~/.dotfiles/config/git/gitconfig ~/.gitconfig

echo "==> Installing Vim plugins"
vim +PluginInstall +qa!

echo "==> Done"
