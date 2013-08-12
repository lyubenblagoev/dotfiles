#!/bin/bash

# Install script for dotfiles

set -e

if [[ ! -d "$dotfiles_path"]]; then 
	if [[ "$1" != "" && -d "$1"]]; then 
		dotfiles_path=$1
	else
		echo "Path to the dotfiles repository is not specified"
		exit 1
	fi
fi

$dotfile_path=`pwd`

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
