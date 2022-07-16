" ===================================================================
" Olivier Guenette Nvim config files
" ===================================================================

if has('unix')
    let g:home_path='~/.config'
endif

if has('win32')
    let g:home_path=$localappdata
    let g:clipboard = {
      \ 'name': 'win32yank',
      \ 'copy': {
      \    '+': 'win32yank.exe -i --crlf',
      \    '*': 'win32yank.exe -i --crlf',
      \  },
      \ 'paste': {
      \    '+': 'win32yank.exe -o --lf',
      \    '*': 'win32yank.exe -o --lf',
      \ },
      \ 'cache_enabled': 0,
      \ }
endif

let g:config_path= home_path . '/nvim'

execute 'source ' . config_path . '/vim-plug/plugins.vim'
execute 'source ' . config_path . '/general/settings.vim'
execute 'source ' . config_path . '/keys/mappings.vim'
execute 'luafile ' . config_path . '/lua/init.lua'

" colorscheme gruvbox
colorscheme onedark

hi Normal guibg=None ctermbg=None

