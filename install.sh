#!/bin/bash
#
# This script should be run via curl:
#   curl -L https://raw.githubusercontent.com/lyubenblagoev/dotfiles/master/install.sh | bash
# or via wget: 
#   wget -qO- https://raw.githubusercontent.com/lyubenblagoev/dotfiles/master/install.sh | bash
#

set -e

# Configure colors
BOLD="\e[1m"
RED="\e[31m"
YELLOW="\e[93m"
BLUE="\e[34m"
RESET="\e[0m"

# Default settings
REPO=${REPO:-lyubenblagoev/dotfiles}
REMOTE=${REMOTE:-https://github.com/${REPO}.git}
BRANCH=${BRANCH:-master}
PURGE_LOCAL=false

log() {
    echo -e "${BOLD}${BLUE}$*${RESET}"
}

warn() {
    echo -e "${BOLD}${YELLOW}$*${RESET}"
}

err() {
    echo -e "${BOLD}${RED}Error: $*${RESET}\n" >&2
    exit 1
}

confirm() {
    echo -en "${BOLD}${YELLOW}$*? [y/N] ${RESET}"
    read -r opt
    case $opt in
        y*|Y*) return 0 ;;
        *) return 1 ;;
    esac
}

command_exists() {
    command -v $@ > /dev/null 2>&1
}

backup_existing() {
    local file=$1
    local backup_file="${file}.bak"

    if [ -h $file ]; then
        if ls -l $file | grep -q "\/.dotfiles\/config\/"; then
            if [ $PURGE_LOCAL = true ]; then
                rm $file
            fi
        else
            log "$file has been renamed to $backup_file"
            mv $file $backup_file
        fi
    elif [ -f $file ] || [ -d $file ]; then
        log "$file has been renamed to $backup_file"
        mv $file $backup_file
    fi
}

create_symlink() {
    local file=$1
    local target=$2

    backup_existing "${file}"
    if [ ! -e $file ] && [ ! -d $file ]; then
        ln -s "$target" "$file"
    fi
}

setup_dotfiles() {
    if [ -d ~/.dotfiles ]; then
        log "~/.dotfiles already exists, update and reinstall"
        if confirm "Purge local configuration"; then
            rm -rf ~/.dotfiles/config/local
            PURGE_LOCAL=yes
        fi
        cd ~/.dotfiles
        git pull origin $BRANCH || err "Failed to pull from GitHub repository"
        cd -
    else
        log "Cloning lyubenblagoev/dotfiles into ~/.dotfiles"
        git clone -b $BRANCH $REMOTE ~/.dotfiles || err "Failed to clone repo from GitHub"
    fi
}

setup_shell() {
    mkdir -p ~/.dotfiles/config/local/bash
    cp ~/.dotfiles/config/bash/env.template ~/.dotfiles/config/local/bash/env
    if ! grep -q .dotfiles\/config\/bash\/env-setup ~/.bashrc; then
        log "Setting-up Bash environment"
        sed -i "$ a [ -r ~/.dotfiles/config/bash/env-setup ] && . ~/.dotfiles/config/bash/env-setup" ~/.bashrc
    fi
}

setup_vim() {
    if [ ! -d ~/.dotfiles/config/local/vim/bundle ]; then
        log "Cloning Vundle into vim/bundle"
        mkdir -p ~/.dotfiles/config/local/vim/bundle
        git clone https://github.com/VundleVim/Vundle.vim.git ~/.dotfiles/config/local/vim/bundle/Vundle.vim \
            || err "Failed to clone Vundle repo from GitHub"
    fi

    create_symlink ~/.vim ~/.dotfiles/config/local/vim
    create_symlink ~/.vimrc ~/.dotfiles/config/vim/vimrc    

    log "Installing Vim plugins"
    vim +PluginInstall +qa!
}

setup_git() {
    if [ ! -d ~/.dotfiles/config/local/git ]; then
        mkdir -p ~/.dotfiles/config/local/git
        cp ~/.dotfiles/config/git/gitconfig ~/.dotfiles/config/local/git/gitconfig
    fi
    create_symlink ~/.gitconfig ~/.dotfiles/config/local/git/gitconfig

    if [ ! -d ~/.config/git/ ]; then
        mkdir -p ~/.config/git
    fi
    create_symlink ~/.config/git/config ~/.dotfiles/config/git/config

    if ! type -t "__git_ps1" > /dev/null 2>&1; then
        curl -L https://raw.github.com/git/git/master/contrib/completion/git-prompt.sh > ~/.dotfiles/config/local/git/git-prompt.sh
    fi
}

main() {
    required_software=("git" "vim")
    for c in ${required_software[@]}; do
        if ! command_exists $c; then
            err "$c is not installed"
            exit 1
        fi
    done

    setup_dotfiles
    setup_shell
    setup_vim
    setup_git

    source ~/.bashrc
}

main
