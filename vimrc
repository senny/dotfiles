" do not run in vi-compatible-mode
set nocompatible
let g:current_os="windows"
let g:vim_config_dir="~/projects/dotfiles/vim/configs"

" activate mswin-behavior
if g:current_os == "windows"
    exe 'source '.expand(g:vim_config_dir."/windows.vim")
endif

exe 'source '.expand(g:vim_config_dir."/functions.vim")
exe 'source '.expand(g:vim_config_dir."/global.vim")
exe 'source '.expand(g:vim_config_dir."/mappings.vim")
exe 'source '.expand(g:vim_config_dir."/display.vim")
exe 'source '.expand(g:vim_config_dir."/plugins.vim")
