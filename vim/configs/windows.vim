if has("gui_running")
    " alt jumps to menu
    set winaltkeys=menu
    " clipboard to autoselect
    set guioptions+=a

    " ---- Windows Like keys ----
    " CTRL-Z is Undo; not in cmdline though
    noremap <C-Z> u
    inoremap <C-Z> <C-O>u
    " CTRL-Y is Redo (although not repeat); not in cmdline though
    noremap <C-Y> <C-R>
    inoremap <C-Y> <C-O><C-R>
    " CTRL-A is Select all
    noremap <C-A> gggH<C-O>G
    inoremap <C-A> <C-O>gg<C-O>gH<C-O>G
    cnoremap <C-A> <C-C>gggH<C-O>G
    " CTRL-F4 is Close window
    noremap <C-F4> <C-W>c
    inoremap <C-F4> <C-O><C-W>c
    cnoremap <C-F4> <C-C><C-W>c
    " CTRL-Tab is Next window
    noremap <C-Tab> <C-W>w
    inoremap <C-Tab> <C-O><C-W>w
    cnoremap <C-Tab> <C-C><C-W>w
    " ---- Windows Like Copy-Paste keys ----
    " CTRL-v is paste
    inoremap <C-v> <esc>"*p<return>i
    noremap <C-v> "*p<return>
    " CTRL-x is cut (in visual mode only)
    vnoremap <C-x> "*d
    " CTRL-c is copy (in visual mode only)
    vnoremap <C-c> "*y
    " ---- Restore some remapped things
    " make real <C-V> (visual block) as <C-Q> available
    noremap <c-q> <c-v>
    inoremap <C-Y> <C-Y>
endif
