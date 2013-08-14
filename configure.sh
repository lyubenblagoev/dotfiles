#!/bin/bash

set -e

INITIAL_DIR=`pwd`

if [[ -d "${1%/}" ]]; then
    DOT_DIR=${1%/}
else 
    echo "Incorrect dotfiles path" >&2
    exit 1
fi

# Remove current configuration
[[ -e $HOME/.gitconfig ]] && rm -f $HOME/.gitconfig
[[ -e $HOME/.vimrc ]] && rm -f $HOME/.vimrc
[[ -d $HOME/.vim ]] && rm -rf $HOME/.vim

# Create symlinks in home directory
ln -s $DOT_DIR/vimrc $HOME/.vimrc
ln -s $DOT_DIR/vim $HOME/.vim
ln -s $DOT_DIR/gitconfig $HOME/.gitconfig

# Init git submodules
cd $DOT_DIR
git submodule init && git submodule update
cd $INITIAL_DIR
