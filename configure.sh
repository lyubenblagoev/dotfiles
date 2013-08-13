#!/bin/bash

# Install script for dotfiles

set -e

initial_path=`pwd`

if [[ -d "${1%/}" ]]; then
    dotfiles_path=${1%/}
else 
    echo "Incorrect dotfiles path" >&2
    exit 1
fi

# Backup current config
[[ -e ~/.gitconfig ]] && mv ~/.gitconfig ~/.gitconfig.bak
[[ -e ~/.vimrc ]] && mv ~/.vimrc ~/.vimrc.bak
[[ -d ~/.vim ]] && mv ~/.vim ~/.vim.bak

# Create symlinks in home directory
ln -s $dotfiles_path/vimrc ~/.vimrc
ln -s $dotfiles_path/vim ~/.vim
ln -s $dotfiles_path/gitconfig ~/.gitconfig

# Init git submodules
cd $dotfiles_path
git submodule update --init
cd $initial_path
