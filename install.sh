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

# Base dotfiles configuration directory
DOTFILES_CONFIG_DIR="$HOME/.dotfiles/config"

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
        if ls -l $file | grep -q "/.dotfiles/config/"; then
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
            rm -rf ${DOTFILES_CONFIG_DIR}/local
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
    local bash_local_dir="${DOTFILES_CONFIG_DIR}/local/bash"
    mkdir -p $bash_local_dir
    cp ${DOTFILES_CONFIG_DIR}/bash/env.template ${bash_local_dir}/env
    if ! grep -q .dotfiles\/config\/bash\/env-setup ~/.bashrc; then
        log "Setting-up Bash environment"
        sed -i "$ a [ -r ${DOTFILES_CONFIG_DIR}/bash/env-setup ] && . ${DOTFILES_CONFIG_DIR}/bash/env-setup" ~/.bashrc
    fi
}

setup_tmux() {
    local tmux_local_dir="${DOTFILES_CONFIG_DIR}/local/tmux"
    local tpm_dir="${tmux_local_dir}/plugins/tpm"

    if [ ! -d $tpm_dir ]; then
        log "Cloning TPM into tmux/plugins/tmp"
        mkdir -p $tpm_dir
        git clone https://github.com/tmux-plugins/tpm $tpm_dir \
            || err "Failed to clone TPM repo from GitHub"
    fi

    create_symlink ~/.tmux.conf ${DOTFILES_CONFIG_DIR}/tmux/tmux.conf
    create_symlink ~/.tmux $tmux_local_dir

    log "Installing tmux plugins"
    tmux start-server
    tmux new-session -d -s __tpm_install_session__ "tmux source-file ~/.tmux.conf"
    ~/.tmux/plugins/tpm/bin/install_plugins
}

setup_vim() {
    local vim_local_dir="${DOTFILES_CONFIG_DIR}/local/vim"
    local bundle_dir="${vim_local_dir}/bundle"

    if [ ! -d $bundle_dir ]; then
        log "Cloning Vundle into vim/bundle"
        mkdir -p $bundle_dir
        git clone https://github.com/VundleVim/Vundle.vim.git ${bundle_dir}/Vundle.vim \
            || err "Failed to clone Vundle repo from GitHub"
    fi

    create_symlink ~/.vim $vim_local_dir
    create_symlink ~/.vimrc ${DOTFILES_CONFIG_DIR}/vim/vimrc

    log "Installing Vim plugins"
    vim +PluginInstall +qa!
}

setup_git() {
    local git_local_dir="${DOTFILES_CONFIG_DIR}/local/git"

    if [ ! -d $git_local_dir ]; then
        mkdir -p $git_local_dir
        cp ${DOTFILES_CONFIG_DIR}/git/gitconfig $git_local_dir/gitconfig
    fi
    create_symlink ~/.gitconfig $git_local_dir/gitconfig

    if [ ! -d ~/.config/git/ ]; then
        mkdir -p ~/.config/git
    fi
    create_symlink ~/.config/git/config ${DOTFILES_CONFIG_DIR}/git/config

    if ! type -t "__git_ps1" > /dev/null 2>&1; then
        curl -L https://raw.github.com/git/git/master/contrib/completion/git-prompt.sh 2>/dev/null > $git_local_dir/git-prompt.sh
    fi
}

setup_auto_update() {
    if command_exists crontab; then
        (crontab -l 2>/dev/null | grep -F -v "0 * * * * cd ~/.dotfiles && git pull --rebase" || true; echo "0 * * * * cd ~/.dotfiles && git pull --rebase >/dev/null 2>&1") | crontab -
    fi
}

main() {
    required_software=("git" "vim" "tmux")
    for c in ${required_software[@]}; do
        if ! command_exists $c; then
            err "$c is not installed"
            exit 1
        fi
    done

    setup_dotfiles
    setup_shell
    setup_tmux
    setup_vim
    setup_git
    setup_auto_update

    source ~/.bashrc
}

main
