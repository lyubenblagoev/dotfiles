set nocompatible
filetype off

set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

Plugin 'VundleVim/Vundle.vim'
Plugin 'tpope/vim-surround'
Plugin 'scrooloose/nerdtree'
Plugin 'ctrlpvim/ctrlp.vim'
Plugin 'c9s/bufexplorer'
Plugin 'msanders/snipmate.vim'
Plugin 'justinmk/vim-ipmotion'
Plugin 'Lokaltog/vim-easymotion'
Plugin 'jwhitley/vim-matchit'
Plugin 'scrooloose/nerdcommenter'
Plugin 'majutsushi/tagbar'
Plugin 'bling/vim-airline'
Plugin 'vim-airline/vim-airline-themes'
Plugin 'fatih/vim-go'
Plugin 'Raimondi/delimitMate'
Plugin 'chriskempson/vim-tomorrow-theme'
Plugin 'mhartington/oceanic-next'
Plugin 'tpope/vim-fugitive'
Plugin 'airblade/vim-gitgutter'
Plugin 'PProvost/vim-ps1'
Plugin 'leafgarland/typescript-vim'

call vundle#end()

filetype plugin indent on

syntax on

set autoindent

set tabstop=4
set softtabstop=4
set shiftwidth=4
set expandtab

set mouse=a

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
set hidden

if has('gui_running')
    " Disabling GUI options works one by one (see :help guioptions)
    set guioptions-=T
    set guioptions-=m
    set guioptions-=r
    set guioptions-=L

    " Set initial gVim windows size
    set lines=41 columns=140
endif
if (has('termguicolors'))
    set termguicolors
endif
set cursorline

" Custom commands to easily switch light and dark colorschemes
function! DarkScheme() 
    colorscheme OceanicNext
    highlight Search guibg=#005544 guifg=#ffffff
endfunction
command! Dark :call DarkScheme()

function! DarkerScheme()
    colorscheme Tomorrow-Night
endfunction
command! Darker :call DarkerScheme()

function! LightScheme()
    colorscheme Tomorrow
endfunction
command! Light :call LightScheme()

" Default colorscheme
silent! call DarkScheme()

let g:airline_powerline_fonts = 1

if has('gui_gtk')
    set guifont=Ubuntu\ Mono\ 11
    set guioptions+=r
elseif has('gui_win32')
    set guifont=Consolas:h10
endif

if &term =~ '256color'
    "Disable background color erace so that color schemes render properly when
    "inside 256-color tmux
    set t_ut=
endif

set enc=utf-8
set fileencoding=utf-8

" Always display the status line
set laststatus=2

" Scrolling
set scrolloff=2

" \ is the leader character
let mapleader = ","

" Use clipboard
set clipboard=unnamed

" Movement mappings
nmap k gk
nmap j gj

" Split movements
noremap <C-j> <C-w><C-j>
noremap <C-k> <C-w><C-k>
noremap <C-h> <C-w><C-h>
noremap <C-l> <C-w><C-l>

" Buffer mappings
nmap <tab> <Esc>:bnext!<CR>
nmap <S-tab> <Esc>:bprev!<CR>
noremap <silent> <leader>bad :1,1000 bd!<cr>
noremap <silent> <leader>bd :bd<cr>

inoremap jj <esc>

" Ctrl-Space for omni completion
imap <c-space> <c-x><c-o>
set omnifunc=syntaxcomplete#Complete

" Reload current file in buffer
nmap <F5> :e!<cr>

nmap <leader>l :set list!<CR>
set listchars=tab:▸\ ,eol:¬

" Read (source) the commands from current file
nmap <leader>s :so %<cr>

" Automatic reloading of .vimrc
autocmd! bufwritepost .vimrc source %

" Quickly edit and source .vimrc
nmap <silent> <leader>ev :e $MYVIMRC<cr>
nmap <silent> <leader>sv :so $MYVIMRC<cr>

" Save and quit mappings
map <leader>w :w <cr>
map :Q  :q <cr>
map <leader>q :q <cr>
map <leader>x :q! <cr>
map <leader>wq :wq <cr>

" Use w!! to write file as root
cmap w!! %!sudo tee > /dev/null %

" NerdTree
let NERDTreeWinSize=38
let NERDTreeQuitOnOpen=1
" NerdTree mappings
map <silent> <F2> :NERDTreeToggle <CR>
imap <silent> <F2> <esc>:NERDTreeToggle <CR>
map <silent> <F7> :NERDTreeFind <CR>
imap <silent> <F7> <esc>:NERDTreeFind <CR>

" Handy shortcuts to toggle QuitOnOpen
map <silent> <leader>nto :let NERDTreeQuitOnOpen=0<CR>
map <silent> <leader>ntc :let NERDTreeQuitOnOpen=1<CR>

" Easily search for all occurrences of current word
nnoremap <F3> :vimgrep /<C-r><c-w>/gj %<CR>:cw<CR>

" Tagbar mappings
map <F8> :TagbarToggle <CR>
let g:tagbar_autoclose = 1

" Hide search highlighting
map <Leader>h :set invhls <cr>

" Disable Ex-Mode
nnoremap Q <nop>

" Turn on numbering
set number
set numberwidth=5

" Case insentitive search 
set ic

au BufNewFile,BufRead *.gradle setf groovy

" Some useful mappings for GO
au FileType go nmap <leader>r <Plug>(go-run)
au FileType go nmap <leader>b <Plug>(go-build)
au FileType go nmap <leader>t <Plug>(go-test)
au FileType go nmap <leader>gd <Plug>(go-doc)
au FileType go nmap <leader>gv <Plug>(go-doc-vertical)
au FileType go nmap <leader>s <Plug>(go-implements)
au FileType go nmap <leader>e <Plug>(go-rename)

" Various file formats
au Filetype go setlocal noet ts=4 sw=4
au FileType c setlocal noet ts=4 sw=4 tw=80
au FileType h setlocal noet ts=4 sw=4 tw=80
au FileType cpp setlocal noet ts=4 sw=4 tw=80
au FileType java setlocal noet ts=4 sw=4
au FileType sh setlocal et ts=4 sw=4
au FileType js setlocal noet ts=4 sw=4
au FileType jsx setlocal noet ts=4 sw=4
au FileType html setlocal noet ts=4 sw=4
au FileType sql setlocal noet ts=4 sw=4
au FileType yaml setlocal et ts=2 sw=2
au FileType yml setlocal et ts=2 sw=2
au FileType ruby set ts=2 sts=2 sw=2

" Add missing imports on Save (GO)
let g:go_fmt_command = "goimports"

" Workaround for delimitMate to expand cr (delimitMate_expand_cr=1 is not working) 
" This is a bit more complicated than {<CR> {<CR>}<ESC>O, but it
" places closing braces more nicely (especially when using () or [])
inoremap {<CR> {}<ESC>i<CR><ESC>O
inoremap (<CR> ()<ESC>i<CR><ESC>O
inoremap [<CR> []<ESC>i<CR><ESC>O
