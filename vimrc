set nocompatible
syntax on

silent! call pathogen#infect()

" Softtabs, 2 spaces
set tabstop=2
set shiftwidth=2
set expandtab

" Indent automatically depending on filetype
filetype plugin indent on
set autoindent

set ruler
set nobackup
set nowritebackup
set showcmd
set incsearch
set ignorecase
set smartcase
set hlsearch
set showmatch
set backspace=indent,eol,start
set history=50
set nowrap
set noswapfile
set visualbell
set cursorline

if has('gui_running')
  " Disabling GUI options works one by one (see :help guioptions)
  set guioptions-=T
  set guioptions-=m
  set guioptions-=r
  set guioptions-=L
  set guifont=DejaVu\ Sans\ Mono:h10

  " Set initial gVim windows size
  set lines=40 columns=160
endif

set enc=utf-8
set fileencoding=utf-8

set winwidth=84
set winheight=5
set winminheight=5
set winheight=999

" Always display the status line
set laststatus=2

" \ is the leader character
let mapleader = ","

inoremap ,, <esc>
map ,w :w <cr>
map ,q :q <cr>
map ,wq :wq <cr>
noremap <C-h> :bprev <cr>
noremap <C-l> :bnext <cr>
map <F2> :NERDTreeToggle <CR>

" hide search highlighting
map <Leader>h :set invhls <cr>

" Change colorscheme from from default to RailsCasts theme http://raw.github.com/ryanb/dotfiles/master/vim/colors/railscasts.vim
colorscheme railscasts

" Turn on numbering
set number
set numberwidth=5
:highlight LineNr term=bold cterm=NONE ctermfg=Grey ctermbg=NONE gui=NONE guifg=DarkGrey guibg=NONE

" Case insentitive search 
set ic

" Highlight search
set hls
