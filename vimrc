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

    " Set initial gVim windows size
    set lines=45 columns=130

    " Set gui theme
    colorscheme slushnpoppies
endif

if has('gui_gtk')
    set guifont=DejaVu\ Sans\ Mono\ 10
elseif has('gui_win32')
    set guifont=DejaVu\ Sans\ Mono:h10
endif

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

" Indentation mappings
nmap <C-[> <<
nmap <C-]> >>
vmap <C-[> <gv
vmap <C-]> >gv

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

" Tagbar mappings
map <F8> :TagbarToggle <CR>

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
let g:session_default_to_last=1

" Insert a disposable marker after the cursor
nmap <leader>ma :MultieditAddMark a<CR>

" Insert a disposable marker before the cursor
nmap <leader>mi :MultieditAddMark i<CR>

" Make a new line and insert a marker
nmap <leader>mo o<Esc>:MultieditAddMark i<CR>
nmap <leader>mO O<Esc>:MultieditAddMark i<CR>

" Insert a marker at the end/start of a line
nmap <leader>mA $:MultieditAddMark a<CR>
nmap <leader>mI ^:MultieditAddMark i<CR>

" Make the current selection/word an edit region
vmap <leader>m :MultieditAddRegion<CR>  
nmap <leader>mm viw:MultieditAddRegion<CR>

" Restore the regions from a previous edit session
nmap <leader>mu :MultieditRestore<CR>

" Move cursor between regions n times
map ]m :MultieditHop 1<CR>
map [m :MultieditHop -1<CR>

" Start editing!
nmap <leader>M :Multiedit<CR>

" Clear the word and start editing
nmap <leader>C :Multiedit!<CR>

" Unset the region under the cursor
nmap <silent> <leader>md :MultieditClear<CR>

" Unset all regions
nmap <silent> <leader>mr :MultieditReset<CR>

