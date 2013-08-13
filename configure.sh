#!/bin/bash

# Install script for dotfiles

set -e

dotfiles_path=`dirname $0`

# Backup current config
[[ -e ~/.gitconfig ]] && mv ~/.gitconfig ~/.gitconfig.bak
[[ -e ~/.vimrc ]] && mv ~/.vimrc ~/.vimrc.bak
[[ -d ~/.vim ]] && mv ~/.vim ~/.vim.bak

# Create symlinks in home directory
ln -s $dotfiles_path/vimrc ~/.vimrc
ln -s $dotfiles_path/vim ~/.vim
ln -s $dotfiles_path/gitconfig ~/.gitconfig

# Init git submodules
git submodule init && git submodule update
