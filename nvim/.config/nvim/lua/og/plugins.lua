-- Install Packer if not installed
local fn = vim.fn
local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"

if fn.empty(fn.glob(install_path)) > 0 then
    packer_bootstrap = fn.system({
        "git",
        "clone",
        "--depth",
        "1",
        "https://github.com/wbthomason/packer.nvim",
        install_path,
    })
    vim.cmd([[packadd packer.nvim]])
end

require("packer").startup(function(use)
    use("wbthomason/packer.nvim")

    -- Some Colorthemes
    use("ful1e5/onedark.nvim")
    use("morhetz/gruvbox")

    -- Better Syntax Support
    use("sheerun/vim-polyglot")

    -- nvim-autopairs
    use("windwp/nvim-autopairs")

    -- LuaLine
    use({
        "nvim-lualine/lualine.nvim",
        requires = { "kyazdani42/nvim-web-devicons", opt = true },
    })

    -- lsp installer
    -- lspconfig
    use({
        "williamboman/mason.nvim",
        "williamboman/mason-lspconfig.nvim",
        "neovim/nvim-lspconfig",
    })
    use("p00f/clangd_extensions.nvim")

    -- lsp autocomplete
    use("hrsh7th/nvim-cmp")
    use("hrsh7th/cmp-buffer")
    use("hrsh7th/cmp-path")
    use("hrsh7th/cmp-nvim-lua")
    use("hrsh7th/cmp-nvim-lsp")
    use("saadparwaiz1/cmp_luasnip")
    use("L3MON4D3/luaSnip")
    use("rafamadriz/friendly-snippets")
    use("honza/vim-snippets")

    -- Telescope
    use({
        "nvim-telescope/telescope.nvim",
        requires = {
            { "nvim-lua/plenary.nvim" },
            { "nvim-telescope/telescope-file-browser.nvim" },
            { "nvim-telescope/telescope-fzy-native.nvim" },
        },
    })

    -- Treesitter
    use({
        "nvim-treesitter/nvim-treesitter",
        run = function()
            require("nvim-treesitter.install").update({ with_sync = true })
        end,
        requires = {
            { "nvim-treesitter/nvim-treesitter-context" },
        },
    })

    -- Formatter
    use("jose-elias-alvarez/null-ls.nvim")

    -- Commenter
    use({
        "numToStr/Comment.nvim",
        config = function()
            require("Comment").setup()
        end,
    })

    -- Startuo Timer
    use("dstein64/vim-startuptime")

    -- Git gutter
    use("airblade/vim-gitgutter")

    use({
        "lewis6991/impatient.nvim",
        config = function()
            require("impatient")
        end,
    })

    use("mfussenegger/nvim-jdtls")
    use("mbbill/undotree")
    use("tpope/vim-fugitive")
    use({
        "nvim-tree/nvim-tree.lua",
        requires = {
            "nvim-tree/nvim-web-devicons", -- optional, for file icons
        },
        tag = "nightly", -- optional, updated every week. (see issue #1193)
    })
    -- use("preservim/nerdtree")
end)
