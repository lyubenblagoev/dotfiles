set nocompatible
syntax on

silent! call pathogen#infect()
silent! call pathogen#helptags()

set tabstop=4
set softtabstop=4
set shiftwidth=4
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
    set guifont=DejaVu\ Sans\ Mono:h10

    " Set initial gVim windows size
    set lines=40 columns=160

    " Set gui theme
    colorscheme wombat
endif

set enc=utf-8
set fileencoding=utf-8

" Always display the status line
set laststatus=2

" \ is the leader character
let mapleader = ","

" Movement mappings
nmap k gk
nmap j gj
nmap <space> <PageDown>
nmap <s-space> <PageUp>

inoremap jk <esc>

nmap <F5> :e!<cr>
nmap <leader>s :so %<cr>

" Indentation mappings
nmap <C-[> <<
nmap <C-]> >>
vmap <C-[> <gv
vmap <C-]> >gv

" Save and quit mappings
map <leader>w :w <cr>
map <C-s> :w<cr>
inoremap <C-s> <esc>:w<cr>a
map <leader>q :q <cr>
map <leader>wq :wq <cr>

" Buffer mappings
nnoremap <C-tab> :b#<cr>
noremap <S-h> :bprev <cr>
noremap <S-l> :bnext <cr>

" Windows mappings
noremap <C-h> <C-w>h<cr>
noremap <C-l> <C-w>l<cr>
noremap <C-j> <C-w>j<cr>
noremap <C-k> <C-w>k<cr>

" NerdTree mappings
map <F2> :NERDTreeToggle <CR>
imap <F2> <esc>:NERDTreeToggle <CR>
map <F7> :NERDTreeFind <CR>
imap <F7> <esc>:NERDTreeFind <CR>

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

" Status line settings
function! IsHelp()
    return &buftype == 'help' ? ' (help) ' : ''
endfunction

set statusline=%{&modified?'\[+]':''}%*
set statusline+=[%t]\ 
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

" Session settings
set sessionoptions+=winpos
let g:session_autoload='yes'
let g:session_autosave='yes'
let g:session_default_to_last="yes"
