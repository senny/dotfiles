""""""""""""""""""""""""""""""""""""""""
" GLOBAL SETTINGS
""""""""""""""""""""""""""""""""""""""""
let maplocalleader = ","
let mapleader = ";"
set nobackup
if MySys() == "windows"
  set dir=c:\\swap\\vim
endif

""""""""""""""""""""""""""""""""""""""""
" INDENTING SETTINGS
""""""""""""""""""""""""""""""""""""""""
set tabstop=2
set shiftwidth=2
set softtabstop=2
set smarttab
set expandtab
set autoindent

""""""""""""""""""""""""""""""""""""""""
" TABS
""""""""""""""""""""""""""""""""""""""""
map ä :tabn<CR>
map ö :tabp<CR>
map <silent> ü :tabnew<CR>
map <silent> è :tabnew<CR>:BufExplorer<CR> 
map $ :q<CR>
map . :e .<CR>
map - :Exp<CR>
set showtabline=2

""""""""""""""""""""""""""""""""""""""""
" SEARCHING
""""""""""""""""""""""""""""""""""""""""
set hlsearch            " highlight search results
set incsearch           
set ignorecase          " case-insensitive search
set smartcase           " use smartcase => case-insensitive with lowercase
