" ===================================================================
" Olivier Guenette Nvim config files
" ===================================================================

if has('unix')
    let g:home_path='~/.config'
endif

if has('win32')
    let g:home_path=$localappdata
    au VimEnter * AirlineToggle
endif

let g:config_path= home_path . '/nvim'

execute 'source ' . config_path . '/vim-plug/plugins.vim'
execute 'source ' . config_path . '/general/settings.vim'
execute 'source ' . config_path . '/keys/mappings.vim'
execute 'luafile ' . config_path . '/lua/init.lua'

" colorscheme gruvbox
colorscheme onedark

hi Normal guibg=None ctermbg=None

