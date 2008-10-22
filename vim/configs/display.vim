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

