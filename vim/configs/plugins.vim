" Plugin: NERDTree
if MySys() == "windows"

elseif MySys() == "mac"
  nmap <silent> <C-t> :NERDTreeToggle<CR>
endif
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
