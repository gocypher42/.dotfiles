local fn = vim.fn
local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
if fn.empty(fn.glob(install_path)) > 0 then
    packer_bootstrap = fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
    vim.cmd [[packadd packer.nvim]]
end

require("packer").startup(function(use)
    use("wbthomason/packer.nvim")
    use("navarasu/onedark.nvim")

    -- Better Syntax Support
    use("sheerun/vim-polyglot")
    -- Auto pairs for '(' '[' '{'
    use("jiangmiao/auto-pairs")
    -- AirLine
    use("vim-airline/vim-airline")
    use("vim-airline/vim-airline-themes")
    -- lsp installer
    use("williamboman/nvim-lsp-installer")
    -- lspconfig
    use("neovim/nvim-lspconfig")
    -- lsp autocomplete
    use("hrsh7th/nvim-cmp")
    use("hrsh7th/cmp-nvim-lsp")
    use("L3MON4D3/luaSnip")
    use("saadparwaiz1/cmp_luasnip")
    -- Telescope
    use({
        "nvim-telescope/telescope.nvim",
        tag = "0.1.0",
        requires = { { "nvim-lua/plenary.nvim" } },
    })
    -- Treesitter
    use({
        "nvim-treesitter/nvim-treesitter",
        run = function()
            require("nvim-treesitter.install").update({ with_sync = true })
        end,
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
    -- C# stuff
    use("OmniSharp/omnisharp-vim")
    -- lazy snippets
    use("rafamadriz/friendly-snippets")
    use("honza/vim-snippets")
end)
