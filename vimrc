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
    set lines=35 columns=165

    set cursorline
endif

if has('gui_gtk')
    set guifont=Monaco\ 9
elseif has('gui_win32')
    set guifont=Consolas:h10
    map <F11> <Esc>:call libcallnr("gvimfullscreen.dll", "ToggleFullScreen", 0)<cr>
endif

colorscheme github

set enc=utf-8
set fileencoding=utf-8

" Always display the status line
set laststatus=2

" Scrolling
set scrolloff=2

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

nmap <silent> <leader>ev :e $MYVIMRC<cr>
nmap <silent> <leader>sv :so $MYVIMRC<cr>

" Save and quit mappings
map <leader>w :w <cr>
map <C-s> :w<cr>
inoremap <C-s> <esc>:w<cr>a
map :Q  :q <cr>
map <leader>q :q <cr>
map <leader>wq :wq <cr>

" Buffer mappings
nnoremap <silent> <C-tab> :b#<cr>
noremap <silent> <F12> :bn<cr>
noremap <silent> <S-F12> :bp<cr>
noremap <silent> <leader>bad :1,1000 bd!<cr>
noremap <silent> <leader>bd :bd<cr>

" Windows mappings
noremap <C-h> <C-w>h<cr>
noremap <C-l> <C-w>l<cr>
noremap <C-j> <C-w>j<cr>
noremap <C-k> <C-w>k<cr>

" NerdTree
let NERDTreeWinSize=38
" NerdTree mappings
map <silent> <F2> :NERDTreeToggle <CR>
imap <silent> <F2> <esc>:NERDTreeToggle <CR>
map <silent> <F7> :NERDTreeFind <CR>
imap <silent> <F7> <esc>:NERDTreeFind <CR>

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

" Status line settings
function! IsHelp()
    return &buftype == 'help' ? ' (help) ' : ''
endfunction

augroup FileModifiedHighlight
    autocmd! ColorScheme *
        \ syn match FileModified "^tags:.*" |
        \ hi FileModified guifg=White guibg=Red gui=bold ctermfg=White ctermbg=Red cterm=bold
augroup end

hi FileModified guifg=White guibg=Red gui=bold ctermfg=White ctermbg=Red cterm=bold

set statusline=%#FileModified#
set statusline+=%{&modified?'\[+]':''}%*
set statusline+=[%t]\ 
set statusline+=%<%{getcwd()}\ 
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
let g:session_autoload='no'
let g:session_autosave='yes'
let g:session_default_to_last=0

nmap <leader>os :OpenSession 
nmap <leader>ss :SaveSession 
nmap <leader>cs :CloseSession <CR>
