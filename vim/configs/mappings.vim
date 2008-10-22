" Indent/Dedent with Tab
inoremap <S-Tab> <C-O><LT><LT>
nnoremap <Tab> >>
nnoremap <S-Tab> <LT><LT>
vnoremap <Tab> >gv
vnoremap <S-Tab> <LT>gv

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
