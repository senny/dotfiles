colorscheme desert
syntax on

set cursorline                      " highlight current line
highlight CursorLine guibg=#171717
set number                          " show line numbers
set encoding=utf-8                  " default encoding
set fileformat=unix                 " default file format
set scrolloff=1
set backspace=indent,eol,start      " backspace should work as expected
set vb                              " visual bell
set ls=2                            " show filename in statusbar
set ruler                           " show position in statusbar
set showmatch                       " show closing brackets
    " do not edit files of these types
set wildignore=*.o,*.obj,*.bak,*.exe,*.pyc,*.swp
autocmd BufEnter * lcd %:p:h        " always switch working directory to directory of current file
    "" highlight long lines (>81)
hi LineTooLong cterm=bold ctermbg=red guibg=darkGrey
match LineTooLong /\%>80v.\+/


" INDENTING SETTINGS
set tabstop=4
set shiftwidth=4
set softtabstop=4
set smarttab
set expandtab
set autoindent
" Indent/Dedent with Tab
inoremap <S-Tab> <C-O><LT><LT>
nnoremap <Tab> >>
nnoremap <S-Tab> <LT><LT>
vnoremap <Tab> >gv
vnoremap <S-Tab> <LT>gv


" SEARCH SETTINGS
set hlsearch
set incsearch


" GUI SETTINGS
if has("gui_running")
    set columns=170
    set lines=51
    set guioptions-=T               " disable toolbar
    set guioptions-=M               " disable menu bar
    set guioptions+=c               " use console dialogs
endif
" Map F2 to add/remove GUI options.
map <silent> <F2> :if &guioptions =~# 'T' <Bar>
                      \set guioptions-=T <Bar>
                      \set guioptions-=m <Bar>
                    \else <Bar>
                      \set guioptions+=T <Bar>
                      \set guioptions+=m <Bar>
                    \endif<CR>


" TABS
map ä :tabn<CR>
map ü :tabp<CR>
map $ :q<CR>
map - :e .<CR>
set showtabline=2                   " always show tab bar


" VARIOUS MAPPINGS
    " toggle syntax
map <D-2> :syntax off<CR>:syntax on<CR>
    " reload .vimrc
map <D-3> :source ~/.vimrc<CR>:filetype detect<CR>:exe ":echo 'vimrc reloaded'"<CR>
    " Mac: replace bad ctrl-space spaces with normal spaces
    " Mac+[4-6] : edit various note files
map <D-4> :tabnew<CR>:e ~/notes/vim/note1.txt<CR>
map <D-5> :tabnew<CR>:e ~/notes/vim/note2.txt<CR>
map <D-6> :tabnew<CR>:e ~/notes/vim/note3.txt<CR>
map <D-7> :nohlsearch<CR>
    " toggle white-space
map <D-8> :%s/ / /g<CR>
    " stop highlighting
map W :set list!<CR>
    " _ : edit vimrc
map _ :tabnew<CR>:e ~/.vimrc<CR>
    " + : edit vimnotes
map + :tabnew<CR>:e ~/.vim/vimnotes<CR>


"" HIGHLIGHTING
autocmd BufRead *.kss set filetype=css
autocmd BufRead *.css.dtml set filetype=css
autocmd BufRead *.zcml set filetype=xml
autocmd BufRead *.props set filetype=cfg


"" FILETYPE (EXECUTE)
autocmd FileType python map <F5> :w<CR>:!python "%"<CR>
autocmd FileType php map <F5> :w<CR>:!php "%"<CR>
autocmd FileType tex map <F5> :w<CR>:!/usr/texbin/pdflatex "%";open *.pdf<CR>


" ---------------------------
" PLUGIN: BUFEXPLORER.VIM
map L :split<CR>:BufExplorer<CR>
map l :BufExplorer<CR>
map ö :tabnew<CR>:BufExplorer<CR>


" ---------------------------
" PLUGIN: PYTHON_EDITING.VIM 
source ~/.vim/ftplugin/python_editing.vim
map f :source ~/.vim/ftplugin/python_editing.vim<CR>


" ---------------------------
" PLUGIN: PYDOC.VIM
" <F1> calls Pydoc
noremap <F1> :call ShowPyDoc('<C-R><C-A>', 1)<CR> 

