set nocompatible
syntax on

silent! call pathogen#infect()
silent! call pathogen#helptags()

set tabstop=4
set shiftwidth=4

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

" Don't wait so long for the next keypress (particularly in ambigious Leader
" situations.
set timeoutlen=500

if has('gui_running')
  " Disabling GUI options works one by one (see :help guioptions)
  set guioptions-=T
  set guioptions-=m
  set guioptions-=r
  set guioptions-=L
  set guifont=DejaVu\ Sans\ Mono:h10

  " Set initial gVim windows size
  set lines=40 columns=160

  " Set gui theme
  set background=light
  colorscheme solarized
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

nmap k gk
nmap j gj

inoremap jk <esc>
map <leader>w :w <cr>
map <C-s> :w<cr>
inoremap <C-s> <esc>:w<cr>a
map <leader>q :q <cr>
map <leader>wq :wq <cr>
noremap <C-h> :bprev <cr>
noremap <C-l> :bnext <cr>

map <F2> :NERDTreeToggle <CR>
map <F7> :NERDTreeFind <CR>

" hide search highlighting
map <Leader>h :set invhls <cr>

nnoremap Q <nop>

" Turn on numbering
set number
set numberwidth=5

" Case insentitive search 
set ic

" Highlight search
set hls

function! IsHelp()
  return &buftype == 'help' ? ' (help) ' : ''
endfunction

function! GetName()
  return expand("%:t") == '' ? '<new>' : expand("%:t")
endfunction

set statusline=%{&modified?'\[+]':''}%*
set statusline+=[%{GetName()}]\ 
set statusline+=%<%{getcwd()}\\\ 
set statusline+=%{IsHelp()}
set statusline+=%{&readonly?'\ (ro)\ ':''}
set statusline+=[
set statusline+=%{strlen(&fenc)?&fenc:'none'}\|
set statusline+=%{&ff}\|
set statusline+=%{strlen(&ft)?&ft:'<unknown>'}
set statusline+=]\ 
set statusline+=%=
set statusline+=Col:%c
set statusline+=,Line:%l
set statusline+=/%L\ 

