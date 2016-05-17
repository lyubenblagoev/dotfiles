set nocompatible
syntax on

silent! call pathogen#infect()
silent! call pathogen#helptags()

set tabstop=4
set softtabstop=4
set shiftwidth=4
set expandtab

set mouse=a

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
set hidden

" Don't wait so long for the next keypress (particularly in ambigious Leader
" situations).
set timeoutlen=500

if has('gui_running')
    " Disabling GUI options works one by one (see :help guioptions)
    set guioptions-=T
    set guioptions-=m
    set guioptions-=r
    set guioptions-=L

    " Set initial gVim windows size
    set lines=41 columns=128
endif
set cursorline

colorscheme Tomorrow-Night

" Custom commands to easily switch light and dark colorschemes
command! DarkScheme colorscheme Tomorrow-Night
command! LightScheme colorscheme Tomorrow

if has('gui_gtk')
    set guifont=Monospace\ 10
    set guioptions+=r
elseif has('gui_win32')
    set guifont=Consolas:h10
    map <F11> <Esc>:call libcallnr("gvimfullscreen.dll", "ToggleFullScreen", 0)<cr>
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

inoremap jj <esc>

" Ctrl-Space for omni completion
imap <c-space> <c-x><c-o>
set omnifunc=syntaxcomplete#Complete

" Reload current file in buffer
nmap <F5> :e!<cr>

" Read (source) the commands from current file
nmap <leader>s :so %<cr>

" Automatic reloading of .vimrc
autocmd! bufwritepost .vimrc source %

" Quickly edit and source .vimrc
nmap <silent> <leader>ev :e $MYVIMRC<cr>
nmap <silent> <leader>sv :so $MYVIMRC<cr>

" Save and quit mappings
map <leader>w :w <cr>
map <C-s> :w<cr>
inoremap <C-s> <esc>:w<cr>a
map :Q  :q <cr>
map <leader>q :q <cr>
map <leader>x :q! <cr>
map <leader>wq :wq <cr>

" Buffer mappings
noremap <silent> <C-l> :bn<cr>
noremap <silent> <C-h> :bp<cr>
noremap <silent> <leader>bad :1,1000 bd!<cr>
noremap <silent> <leader>bd :bd<cr>

" Tab mappings
nnoremap <silent> <C-tab> :tabnext<cr>
nnoremap <silent> <C-S-tab> :tabprev<cr>
inoremap <silent> <C-tab> <esc>:tabnext<cr>
inoremap <silent> <C-S-tab> <esc>:tabprev<cr>
vnoremap <silent> <C-tab> <esc>:tabnext<cr>
vnoremap <silent> <C-S-tab> <esc>:tabprev<cr>

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
nnoremap <C-k> :vimgrep /<C-r><c-w>/gj %<CR>:cw<CR>

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

" Highlight search
set hls

map gd :YcmCompleter GoToDefinition<CR>

let g:ycm_autoclose_preview_window_after_completion = 1
let g:ycm_autoclose_preview_window_after_insertion = 1

let g:ycm_global_ycm_extra_conf = '~/.vim/.ycm_extra_conf.py'
let g:ycm_confirm_extra_conf = 0


au BufNewFile,BufRead *.gradle setf groovy
au FileType ruby set ts=2 sts=2 sw=2

" Some useful mappings for GO
au FileType go nmap <leader>r <Plug>(go-run)
au FileType go nmap <leader>b <Plug>(go-build)
au FileType go nmap <leader>t <Plug>(go-test)
au FileType go nmap <leader>gd <Plug>(go-doc)
au FileType go nmap <leader>gv <Plug>(go-doc-vertical)
au FileType go nmap <leader>s <Plug>(go-implements)
au FileType go nmap <leader>e <Plug>(go-rename)

" Add missing imports on Save (GO)
let g:go_fmt_command = "goimports"

" Remap snipmate trigger key (tab is used for completion)
" :help snipMate-remap
ino <silent> <leader>j <esc>a<c-r>=TriggerSnippet()<cr>
snor <silent> <leader>j <esc>i<right><c-r>=TriggerSnippet()<cr>
ino <silent> <leader><s-j> <c-r>=BackwardsSnippet()<cr>
snor <silent> <leader><s-j> <esc>i<right><c-r>=BackwardsSnippet()<cr>

