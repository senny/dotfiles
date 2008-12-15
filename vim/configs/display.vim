""""""""""""""""""""""""""""""""""""""""
" GUI SETTINGS
""""""""""""""""""""""""""""""""""""""""
if has("gui_running")
   set lines=76 columns=180        "display in fullscreen
   set guioptions-=T               " disable toolbar
   set guioptions+=c               " use console dialogs

    if g:current_os == "windows"
        "Run in fullscreen mode
        set lines=99999 columns=99999 "display in fullscreen
        set guioptions-=M             " disable menu bar
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
" DISPLAY SETTINGS
""""""""""""""""""""""""""""""""""""""""
colorscheme desert
syntax on

set foldmethod=marker
set cursorline                      " highlight current line
highlight CursorLine guibg=#222222
set number                          " show line numbers
if g:current_os == "mac"
  set guifont=Monaco:h14
elseif g:current_os == "windows"
  set guifont=Monaco:h10:b
endif
set scrolloff=1
set backspace=indent,eol,start      " backspace should work as expected
set ls=2                            " show filename in statusbar
set ruler                           " show position in statusbar
set showmatch                       " show closing brackets
set wildignore=*.o,*.obj,*.bak,*.exe,*.pyc,*.swp,*.class " do not edit files of these types

if g:current_os == "windows"
    set fileformat=dos
elseif g:current_os == "mac"
    set encoding=utf-8                  " default encoding
    set fileformat=unix                 " default file format
endif

" filetype highlighting
autocmd BufRead *.props set filetype=cfg
autocmd BufRead *.esp set filetype=javascript
autocmd BufRead *.any set filetype=any
au BufRead,BufNewFile *.js set ft=javascript.jquery


"ruby
autocmd FileType ruby,eruby set omnifunc=rubycomplete#Complete
autocmd FileType ruby,eruby let g:rubycomplete_buffer_loading = 1
autocmd FileType ruby,eruby let g:rubycomplete_rails = 1
autocmd FileType ruby,eruby let g:rubycomplete_classes_in_global = 1
"improve autocomplete menu color
highlight Pmenu ctermbg=238 gui=bold
