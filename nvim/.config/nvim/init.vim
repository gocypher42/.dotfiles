
if has('unix')
    let g:custom_home_path='~/.config'
endif

if has('win32')
    let g:custom_home_path=$localappdata
    au VimEnter * AirlineToggle
endif

execute 'source ' . custom_home_path . '/nvim/vim-plug/plugins.vim'
execute 'source ' . custom_home_path . '/nvim/plug-config/coc.vim'
execute 'source ' . custom_home_path . '/nvim/plug-config/fzf.vim'
execute 'source ' . custom_home_path . '/nvim/general/settings.vim'
execute 'source ' . custom_home_path . '/nvim/keys/mappings.vim'
    
colorscheme gruvbox

hi Normal guibg=None ctermbg=None

:command FormatJson %!python3 -m json.tool
