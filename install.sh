#!/bin/bash

set -e

DOT_DIR=$HOME/.dotfiles
INITIAL_DIR=`pwd`

command -v git > /dev/null || { echo 'GIT is required but not found.'; exit 1; }
command -v vim > /dev/null || { echo 'VIM is required but not found.'; exit 1; }

if [[ ! -d $DOT_DIR ]]; then 
    mkdir -p $DOT_DIR
fi 

cd $DOT_DIR
umask 022
git clone https://github.com/lyubenblagoev/dotfiles .
chmod 700 configure.sh install.sh
./configure.sh $DOT_DIR
cd $INITIAL_DIR
