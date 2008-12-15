" Vim plugin for editing compressed files.
" Maintainer: Yves Senn <senny@post.ch>
" Last Change: 2008 SEP 23

" Exit quickly when:
" - this plugin was already loaded
" - when 'compatible' is set
" - some autocommands are already taking care of compressed files
if exists("loaded_fipo")

endif
let loaded_fipo = 1

let s:pattern = '^\(.* \)\([1-9][0-9]*\)$'
let s:minfontsize = 8
let s:maxfontsize = 16
function! AdjustFontSize(amount)
  if has("gui_running")
    let fontname = substitute(&guifont, s:pattern, '\1', '')
    let cursize = substitute(&guifont, s:pattern, '\2', '')
    let newsize = cursize + a:amount
    if (newsize >= s:minfontsize) && (newsize <= s:maxfontsize)
      let newfont = fontname . newsize
      let &guifont = newfont
    endif
  else
    echoerr "You need to run the GTK2 version of Vim to use this function."
  endif
endfunction

function! LargerFont()
  call AdjustFontSize(1)
endfunction
command! LargerFont call LargerFont()

function! SmallerFont()
  call AdjustFontSize(-1)
endfunction
command! SmallerFont call SmallerFont()

function! Find(name)
   let l:_name = substitute(a:name, '\s', '*', 'g')
   let l:list=system("find . -ipath '*".l:_name."*' -not -path '*/.*'  
| perl -ne 'print \"$.\\t$_\"'")
   let l:num=strlen(substitute(l:list, "[^\n]", "", "g"))
   if l:num < 1
     echo "'".a:name."' not found"
     return
   endif

   if l:num != 1
     echo l:list
     let l:input=input("Which ? (<enter>=nothing)\n")

     if strlen(l:input)==0
       return
     endif

     if strlen(substitute(l:input, "[0-9]", "", "g"))>0
       echo "Not a number"
       return
     endif

     if l:input<1 || l:input>l:num
       echo "Out of range"
       return
     endif

     let l:line=matchstr("\n".l:list, "\n".l:input."\t[^\n]*")
   else
     let l:line=l:list
   endif

   let l:line=substitute(l:line, "^[^\t]*\t./", "", "")
   execute ":e ".l:line
endfunction

command! -nargs=1 Find :call Find("<args>") map ,f :Fi
