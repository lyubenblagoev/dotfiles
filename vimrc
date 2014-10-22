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
    set lines=41 columns=148

    set cursorline
endif

colorscheme jellybeans

if has('gui_gtk')
    set guifont=Monospace\ 10
    set colorcolumn=120
    set guioptions+=r
elseif has('gui_win32')
    set guifont=Consolas:h10
    map <F11> <Esc>:call libcallnr("gvimfullscreen.dll", "ToggleFullScreen", 0)<cr>
    set colorcolumn=120
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
noremap <silent> <F12> :bn<cr>
noremap <silent> <S-F12> :bp<cr>
noremap <silent> <leader>bad :1,1000 bd!<cr>
noremap <silent> <leader>bd :bd<cr>

" Tab mappings
nnoremap <silent> <C-tab> :tabnext<cr>
nnoremap <silent> <C-S-tab> :tabprev<cr>
inoremap <silent> <C-tab> <esc>:tabnext<cr>
inoremap <silent> <C-S-tab> <esc>:tabprev<cr>
vnoremap <silent> <C-tab> <esc>:tabnext<cr>
vnoremap <silent> <C-S-tab> <esc>:tabprev<cr>

" Windows mappings
noremap <C-h> <C-w>h<cr>
noremap <C-l> <C-w>l<cr>
noremap <C-j> <C-w>j<cr>
noremap <C-k> <C-w>k<cr>

" NerdTree
let NERDTreeWinSize=38
let NERDTreeQuitOnOpen=1
" NerdTree mappings
map <silent> <F2> :NERDTreeToggle <CR>
imap <silent> <F2> <esc>:NERDTreeToggle <CR>
map <silent> <F7> :NERDTreeFind <CR>
imap <silent> <F7> <esc>:NERDTreeFind <CR>

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
set sessionoptions+=winpos,resize
set sessionoptions-=options
let g:session_autoload='no'
let g:session_autosave='yes'
let g:session_default_to_last=0

nmap <leader>os :OpenSession 
nmap <leader>ss :SaveSession 
nmap <leader>cs :CloseSession <CR>

au BufNewFile,BufRead *.gradle setf groovy
au FileType ruby set ts=2 sts=2 sw=2
