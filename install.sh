#!/bin/bash

set -e

dotfiles_path=$HOME/dotfiles

command -v git > /dev/null || { echo 'GIT is required but not found.'; exit 1; }
command -v vim > /dev/null || { echo 'VIM is required but not found.'; exit 1; }

if [[ ! -d $dotfiles_path ]]; then 
	mkdir -p $dotfiles_path
fi 

git clone https://github.com/lyubenblagoev/features/webinstall/dotfiles $dotfiles_path

chmod 700 $dotfiles_path/configure.sh
echo "$dotfiles_path/configure.sh"
