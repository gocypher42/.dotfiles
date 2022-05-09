call plug#begin(home_path . '/nvim/autoload/plugged')
    " Better Syntax Support
    Plug 'sheerun/vim-polyglot'
    " Auto pairs for '(' '[' '{'
    Plug 'jiangmiao/auto-pairs'
    " Gruvbox theme
    Plug 'morhetz/gruvbox'    
    " Vimtex
    Plug 'lervag/vimtex'
    " AirLine
    Plug 'vim-airline/vim-airline'
    Plug 'vim-airline/vim-airline-themes'
    " Onedark Theme
    Plug 'joshdick/onedark.vim'
    " lspconfig
    Plug 'neovim/nvim-lspconfig'
    " lsp autocomplete
    Plug 'hrsh7th/nvim-cmp' 
    Plug 'hrsh7th/cmp-nvim-lsp'
    Plug 'hrsh7th/cmp-buffer'
    Plug 'hrsh7th/cmp-path'
    Plug 'L3MON4D3/luaSnip'
    Plug 'saadparwaiz1/cmp_luasnip'
    " Telescope
    Plug 'nvim-lua/plenary.nvim'
    Plug 'nvim-telescope/telescope.nvim'
    " Treesitter
    Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}    
    " lsp installer
    Plug 'williamboman/nvim-lsp-installer'
    " Formatter
    Plug 'jose-elias-alvarez/null-ls.nvim' 
    " Commenter
    Plug 'numToStr/Comment.nvim'
call plug#end()
