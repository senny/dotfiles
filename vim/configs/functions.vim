" determines the current operating-system ["windows","mac"]
fun! MySys()
  return g:current_os
endfun

function! ToggleFolding()
    if &foldlevel == 0
        set foldlevel=999
    else
        set foldlevel=0
    endif
endfunction
