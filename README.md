# Dotfiles
Configuration files, mostly for [Vim].

## Installation

Clone the repository in a folder named `.dotfiles` located in your home directory:

```bash
git clone https://github.com/lyubenblagoev/dotfiles.git ~/.dotfiles
```

Create symlinks for `.vimrc`, `.gitconfig` and `.vim`:

```bash
mkdir -p ~/.dotfiles/vim/bundle
ln -s ~/.dotfiles/vim ~/.vim
ln -s ~/.dotfiles/vimrc ~/.vimrc
ln -s ~/.dotfiles/gitconfig ~/.gitconfig
```

Install [Vundle]:

```bash
git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
```

Launch `vim` and run `PluginInstall`.

[Vim]:http://www.vim.org
[Vundle]:https://github.com/VundleVim/Vundle.vim
