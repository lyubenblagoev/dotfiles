set nocompatible
syntax on

silent! call pathogen#infect()

filetype on
filetype indent on
filetype plugin on

set ruler
set nobackup
set nowritebackup
set showcmd
set incsearch
set ignorecase
set smartcase
set hlsearch
set showmatch
set autoindent
set backspace=indent,eol,start
set history=50
set nowrap

if has('gui_running')
  set guioptions-=T
  set guioptions-=m
  set guioptions-=r
  set guioptions-=L
  set guifont=Consolas

  set lines=999 columns=999
endif

set enc=utf-8
set fileencoding=utf-8

set winwidth=84
set winheight=5
set winminheight=5
set winheight=999

" Softtabs, 4 spaces
set tabstop=4
set shiftwidth=4
set expandtab

" Always display the status line
set laststatus=2

" \ is the leader character
let mapleader = ","

inoremap jk <esc>
map ,w :w <cr>
map ,q :q <cr>
map ,wq :wq <cr>
noremap <C-h> :bprev <cr>
noremap <C-l> :bnext <cr>

" hide search highlighting
map <Leader>h :set invhls <cr>

" Change colorscheme from from default to RailsCasts theme http://raw.github.com/ryanb/dotfiles/master/vim/colors/railscasts.vim
colorscheme railscasts

" Indent automatically depending on filetype
filetype indent on
set autoindent

" Turn on numbering
set number
set numberwidth=5
:highlight LineNr term=bold cterm=NONE ctermfg=Grey ctermbg=NONE gui=NONE guifg=DarkGrey guibg=NONE

" Case insentitive search 
set ic

" Highlight search
set hls
