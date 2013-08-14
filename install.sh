#!/bin/bash

DOT_DIR=$HOME/.dotfiles
INITIAL_DIR=`pwd`

command -v git > /dev/null
if [[ $? != 0 ]]; then
    echo 'Git is required, but not found. Aborting.' >&2
    exit 1
fi 
command -v vim > /dev/null
if [[ $? != 0 ]]; then
    echo 'Vim is required, but not found. Aborting.' >&2
    exit 1
fi

if [[ ! -d $DOT_DIR ]]; then 
    mkdir -p $DOT_DIR
    cd $DOT_DIR && git clone https://github.com/lyubenblagoev/dotfiles .
else
    echo "Dotfiles is already installed in $DOT_DIR, trying to update"
    cd $DOT_DIR && git pull
fi

chmod 700 configure.sh install.sh
./configure.sh $DOT_DIR

cd $INITIAL_DIR
