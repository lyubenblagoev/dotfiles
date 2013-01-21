set ruler
set nobackup
set nowritebackup
set showcmd
set incsearch
set history=50
set nowrap

" Softtabs, 2 spaces
set tabstop=2
set shiftwidth=2
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
