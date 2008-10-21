" Vim plugin for editing compressed files.
" Maintainer: Yves Senn <senny@post.ch>
" Last Change: 2008 SEP 23

" Exit quickly when:
" - this plugin was already loaded
" - when 'compatible' is set
" - some autocommands are already taking care of compressed files
if exists("loaded_todo")
  finish
endif
let loaded_todo = 1



setlocal commentstring=*\ %s

function! s:CreateToDoBlock()
    let name = inputdialog('Enter TODO-Name: ')
    
    if name == ""
        return
    endif

    call append(0, '************************************************************')
    call append(1, '* {{{      '.name )
    call append(2, '* KVA-Nr:')
    call append(3, '* Release:')
    call append(4, '************************************************************')
    call append(5, '')
    call append(6, '')
    call cursor(6,0)
    call append(7, '* }}} ')
    call append(8,'')

endfunction


command -nargs=0 CreateToDo call <SID>CreateToDoBlock()
nnoremap <silent> <buffer> <LocalLeader>t :call <SID>CreateToDoBlock()<Cr>

