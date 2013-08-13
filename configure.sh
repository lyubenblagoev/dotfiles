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

# Remove current configuration
[[ -e $HOME/.gitconfig ]] && rm -f $HOME/.gitconfig
[[ -e $HOME/.vimrc ]] && rm -f $HOME/.vimrc
[[ -d $HOME/.vim ]] && rm -rf $HOME/.vim

# Create symlinks in home directory
ln -s $dotfiles_path/vimrc $HOME/.vimrc
ln -s $dotfiles_path/vim $HOME/.vim
ln -s $dotfiles_path/gitconfig $HOME/.gitconfig

# Init git submodules
cd $dotfiles_path
git submodule update --init
cd $initial_path
