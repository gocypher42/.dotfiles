call plug#begin(custom_home_path . '/nvim/autoload/plugged')

    " Better Syntax Support
    Plug 'sheerun/vim-polyglot'
    " File Explorer
    " Plug 'scrooloose/NERDTree'
    " Auto pairs for '(' '[' '{'
    Plug 'jiangmiao/auto-pairs'
    " Gruvbox theme
    Plug 'morhetz/gruvbox'    
    " COC
    Plug 'neoclide/coc.nvim', {'branch': 'master', 'do': 'yarn install --frozen-lockfile'}
    " Vimtex
    Plug 'lervag/vimtex'
    " AirLine
    Plug 'vim-airline/vim-airline'
    Plug 'vim-airline/vim-airline-themes'
    " Onedark Theme
    Plug 'joshdick/onedark.vim'
    " FZF
    Plug 'junegunn/fzf', {'do': {->fzf#install()}}    
    Plug 'junegunn/fzf.vim'
call plug#end()
