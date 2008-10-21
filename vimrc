" do not run in vi-compatible-mode
set nocompatible

" determines the current operating-system ["windows","mac"]
fun! MySys()
  return "mac"
endfun

function! ToggleFolding()
    if &foldlevel == 0
        set foldlevel=999
    else
        set foldlevel=0
    endif
endfunction

" activate mswin-behavior
if MySys() == "windows"
    source $VIMRUNTIME/vimrc_example.vim
    source $VIMRUNTIME/mswin.vim
    behave mswin
endif

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
" DISPLAY SETTINGS
""""""""""""""""""""""""""""""""""""""""
colorscheme desert
syntax on

set foldmethod=marker
set cursorline                      " highlight current line
highlight CursorLine guibg=#222222
set number                          " show line numbers
if MySys() == "mac"
  set guifont=Monaco:h14
elseif MySys() == "windows"
  set guifont=Monaco:h10:b
endif
set scrolloff=1
set backspace=indent,eol,start      " backspace should work as expected
set ls=2                            " show filename in statusbar
set ruler                           " show position in statusbar
set showmatch                       " show closing brackets
set wildignore=*.o,*.obj,*.bak,*.exe,*.pyc,*.swp,*.class " do not edit files of these types

if MySys() == "windows"
    set fileformat=dos
elseif MySys() == "mac"
    set encoding=utf-8                  " default encoding
    set fileformat=unix                 " default file format
endif

" filetype highlighting
autocmd BufRead *.props set filetype=cfg
autocmd BufRead *.esp set filetype=javascript

""""""""""""""""""""""""""""""""""""""""
" GUI SETTINGS
""""""""""""""""""""""""""""""""""""""""
if has("gui_running")
   set lines=76 columns=180        "display in fullscreen
   set guioptions-=T               " disable toolbar
   set guioptions+=c               " use console dialogs

    if MySys() == "windows"
        "Run in fullscreen mode
   	set lines=99999 columns=99999 "display in fullscreen
   	set guioptions-=M               " disable menu bar
        autocmd GUIEnter * simalt ~X
    endif

endif

" Map F2 to add/remove GUI options.
map <silent> <F2> :if &guioptions =~# 'T' <Bar>
                      \set guioptions-=T <Bar>
                      \set guioptions-=m <Bar>
                    \else <Bar>
                      \set guioptions+=T <Bar>
                      \set guioptions+=m <Bar>
                    \endif<CR>

""""""""""""""""""""""""""""""""""""""""
" INDENTING SETTINGS
""""""""""""""""""""""""""""""""""""""""
set tabstop=2
set shiftwidth=2
set softtabstop=2
set smarttab
set expandtab
set autoindent
" Indent/Dedent with Tab
inoremap <S-Tab> <C-O><LT><LT>
nnoremap <Tab> >>
nnoremap <S-Tab> <LT><LT>
vnoremap <Tab> >gv
vnoremap <S-Tab> <LT>gv

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

""""""""""""""""""""""""""""""""""""""""
" CUSTOM MAPPINGS
""""""""""""""""""""""""""""""""""""""""
if MySys() == "windows"
    map _ :tabnew<CR>:e C:\Program Files\Vim\_vimrc<CR>
    map + :tabnew<CR>:e C:\Program Files\Vim\vimfiles\vimnotes<CR>
    map <C-t> :tabnew<CR>:e C:\Documents and Settings\senny\Desktop\TODO.txt<CR>
    " Make font-size bigger
    nnoremap <C-S-Up> :silent! let &guifont = substitute(
       \ &guifont,
       \ ':h\zs\d\+',
       \ '\=eval(submatch(0)+1)',
       \ '')<CR>
    " Make font-size smaller
    nnoremap <C-S-Down> :silent! let &guifont = substitute(
       \ &guifont,
       \ ':h\zs\d\+',
       \ '\=eval(submatch(0)-1)',
       \ '')<CR>


    " turn syntax-highlighting on/off
    map <S-1> :syntax off<CR>:syntax on<CR>
    " disable search-highlighting
    map <S-2> :nohlsearch<CR>
    " reload .vimrc
    map <S-3> :source C:\Program Files\Vim\_vimrc<CR>:filetype detect<CR>:exe ":echo 'vimrc reloaded'"<CR>
elseif MySys() == "mac"
    map _ :tabnew<CR>:e ~/.vimrc<CR>
    map + :tabnew<CR>:e ~/.vim/vimnotes<CR>
    map <D-t> :tabnew<CR>:e ~/TODO.txt
    " turn syntax-highlighting on/off
    map <D-1> :syntax off<CR>:syntax on<CR>
    " disable search-highlighting
    map <D-2> :nohlsearch<CR>
    " reload .vimrc
    map <D-3> :source ~/.vimrc<CR>:filetype detect<CR>:exe ":echo 'vimrc reloaded'"<CR>
endif

""""""""""""""""""""""""""""""""""""""""
" PLUGIN SECTION
""""""""""""""""""""""""""""""""""""""""
" Plugin: Project
nmap <silent> <C-d> :call ToggleFolding()<CR>
nmap <silent> <A-Left> zc
nmap <silent> <A-Right> zo
nmap <C-p> <Plug>ToggleProject

let g:proj_flags = 'v'

" Plugin: BufExplorer
map L :split<CR>:BufExplorer<CR>
map l :BufExplorer<CR>

" Plugin: TagList
nnoremap <silent> <F3> :TlistToggle<CR>
let Tlist_WinWidth = 50

"Plugin: TODO
au BufRead,BufNewFile TODO.txt		set filetype=todo

" Plugin: Grep
function! SearchWithList()
    call inputsave()
    let search_string=inputdialog('Enter a search string: ')
    if search_string==""
        return
    endif
    execute 'Grep -i "' . search_string . '" "' . expand('%') . '"'
endfunction
map <C-f> :call SearchWithList()<CR>
