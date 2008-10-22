" do not run in vi-compatible-mode
set nocompatible
let g:current_os="mac"

source ~/.vim/configs/functions.vim
source ~/.vim/configs/global.vim
source ~/.vim/configs/mappings.vim
source ~/.vim/configs/display.vim
source ~/.vim/configs/plugins.vim

" activate mswin-behavior
if MySys() == "windows"
    source $VIMRUNTIME/vimrc_example.vim
    source $VIMRUNTIME/mswin.vim
    behave mswin
endif
