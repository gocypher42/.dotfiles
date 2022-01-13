source ~/.config/nvim/vim-plug/plugins.vim
source ~/.config/nvim/plug-config/coc.vim
source ~/.config/nvim/general/settings.vim
source ~/.config/nvim/keys/mappings.vim

colorscheme onedark
set background=dark

"hi Normal guibg=None ctermbg=None

:command FormatJson %!python3 -m json.tool
