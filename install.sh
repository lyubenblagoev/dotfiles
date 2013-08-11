#!/bin/bash

# Install script for dotfiles

set -e

DOTFILES=`pwd`

# Backup current config
[[ -e ~/.gitconfig ]] && mv ~/.gitconfig ~/.gitconfig.bak
[[ -e ~/.vimrc ]] && mv ~/.vimrc ~/.vimrc.bak
[[ -d ~/.vim ]] && mv ~/.vim ~/.vim.bak

# Create symlinks in home directory
ln -s $DOTFILES/vimrc ~/.vimrc
ln -s $DOTFILES/vim ~/.vim
ln -s $DOTFILES/gitconfig ~/.gitconfig

# Init git submodules
git submodule init && git submodule update
