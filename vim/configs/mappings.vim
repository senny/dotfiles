" Indent/Dedent with Tab
inoremap <S-Tab> <C-O><LT><LT>
nnoremap <Tab> >>
nnoremap <S-Tab> <LT><LT>
vnoremap <Tab> >gv
vnoremap <S-Tab> <LT>gv

"Browsing / Tabs
map ä :tabn<CR>
map ö :tabp<CR>
map <silent> ü :tabnew<CR>
map <silent> è :tabnew<CR>:BufExplorer<CR>
map $ :q<CR>
map . :e .<CR>
map - :Exp<CR>

" Visual Mode Mappings
vmap / y/<C-R>"<CR>

" Edit configuration-directory
map + :tabnew<CR>:exe 'e '.expand(g:vim_config_dir)<CR>

" Resize split-screen panes
nmap <silent><C-S-Right> :vertical-resize +2<CR>
nmap <silent><C-S-Left> :vertical-resize -2<CR>
nmap <silent><C-S-Up> :resize -2<CR>
nmap <silent><C-S-Down> :resize +2<CR>

" Appends / insert current date
nmap <Leader>d "=strftime("%d.%m.%Y")<CR>p
nmap <Leader>D "=strftime("%d.%m.%Y")<CR>P

" Changes directory to the one of the current file
nmap <Leader>h :cd%:h<CR>

" disable search-highlighting
map <silent><F1> :nohlsearch<CR>


if g:current_os == "windows"
    nmap _ :tabnew<CR>:e C:\Program Files\Vim\_vimrc<CR>
    nmap <C-t> :tabnew<CR>:e C:\Documents and Settings\senny\Desktop\TODO.txt<CR>
    nmap <C-n> :tabnew<CR>:e C:\Documents and Settings\senny\Desktop\NOTES.txt<CR>
    nmap <C-l> :NERDTreeToggle<CR>
    map <C-o> :OpenFipoProject<CR>
    " ^M Steuerzeichen ersetzen
    map <silent><C-S-m> :%s//m\r/g<CR>
    " Make font-size bigger
    nnoremap <C-A-Up> :silent! let &guifont = substitute(
       \ &guifont,
       \ ':h\zs\d\+',
       \ '\=eval(submatch(0)+1)',
       \ '')<CR>
    " Make font-size smaller
    nnoremap <C-A-Down> :silent! let &guifont = substitute(
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
elseif g:current_os == "mac"
    map _ :tabnew<CR>:e ~/.vimrc<CR>
    map <D-t> :tabnew<CR>:e ~/TODO.txt
    " turn syntax-highlighting on/off
    map <D-1> :syntax off<CR>:syntax on<CR>
       " reload .vimrc
    map <D-3> :source ~/.vimrc<CR>:filetype detect<CR>:exe ":echo 'vimrc reloaded'"<CR>
endif
