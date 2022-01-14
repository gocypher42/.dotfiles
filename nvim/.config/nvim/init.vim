
if has('unix')
    source ~/.config/nvim/vim-plug/plugins.vim
    source ~/.config/nvim/plug-config/coc.vim
    source ~/.config/nvim/plug-config/fzf.vim
    source ~/.config/nvim/general/settings.vim
    source ~/.config/nvim/keys/mappings.vim
endif

if has('win32')
    source ~/.config/nvim/vim-plug/plugins.vim
    source ~/.config/nvim/plug-config/coc.vim
    source ~/.config/nvim/plug-config/fzf.vim
    source ~/.config/nvim/general/settings.vim
    source ~/.config/nvim/keys/mappings.vim
endif

colorscheme gruvbox

"hi Normal guibg=None ctermbg=None

:command FormatJson %!python3 -m json.tool
