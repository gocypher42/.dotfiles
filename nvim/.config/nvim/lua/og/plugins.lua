-- [[ Configure plugins ]]
-- NOTE: Here is where you install your plugins.
--  You can configure plugins using the `config` key.
--
--  You can also configure plugins after the setup call,
--    as they will be available in your neovim runtime.
require("lazy").setup({
    -- NOTE: First, some plugins that don't require any configuration
  
    -- Git related plugins
    "tpope/vim-fugitive",
    "tpope/vim-rhubarb",
  
    -- Detect tabstop and shiftwidth automatically
    "tpope/vim-sleuth",
  
    {
      -- LSP Configuration & Plugins
      "neovim/nvim-lspconfig",
      dependencies = {
        "williamboman/mason.nvim",
        "williamboman/mason-lspconfig.nvim",
  
        -- Useful status updates for LSP
        -- NOTE: `opts = {}` is the same as calling `require('fidget').setup({})`
        { "j-hui/fidget.nvim", tag = "legacy", opts = {} },
  
        "folke/neodev.nvim",
      },
    },
    { "p00f/clangd_extensions.nvim", opts = {} },
  
    {
      -- Autocompletion
      "hrsh7th/nvim-cmp",
      dependencies = {
        "L3MON4D3/LuaSnip",
        "saadparwaiz1/cmp_luasnip",
        "hrsh7th/cmp-nvim-lsp",
        "rafamadriz/friendly-snippets",
        "hrsh7th/cmp-buffer",
      },
    },
  
    -- Useful plugin to show you pending keybinds.
    { "folke/which-key.nvim", opts = {} },
    {
      "lewis6991/gitsigns.nvim",
      opts = {
        signs = {
          add = { text = "+" },
          change = { text = "~" },
          delete = { text = "_" },
          topdelete = { text = "‾" },
          changedelete = { text = "~" },
        },
        on_attach = function(bufnr)
          vim.keymap.set(
            "n",
            "<leader>hp",
            require("gitsigns").preview_hunk,
            { buffer = bufnr, desc = "Preview git hunk" }
          )
  
          local gs = package.loaded.gitsigns
          vim.keymap.set({ "n", "v" }, "]c", function()
            if vim.wo.diff then
              return "]c"
            end
            vim.schedule(function()
              gs.next_hunk()
            end)
            return "<Ignore>"
          end, { expr = true, buffer = bufnr, desc = "Jump to next hunk" })
          vim.keymap.set({ "n", "v" }, "[c", function()
            if vim.wo.diff then
              return "[c"
            end
            vim.schedule(function()
              gs.prev_hunk()
            end)
            return "<Ignore>"
          end, {
            expr = true,
            buffer = bufnr,
            desc = "Jump to previous hunk",
          })
        end,
      },
    },
  
    {
      -- Theme inspired by Atom
      "navarasu/onedark.nvim",
      priority = 1000,
      config = function()
        vim.cmd.colorscheme("onedark")
      end,
    },
  
    {
      "nvim-lualine/lualine.nvim",
      opts = {
        options = {
          icons_enabled = false,
          theme = "onedark",
          component_separators = "|",
          section_separators = "",
        },
      },
    },
  
    {
      "lukas-reineke/indent-blankline.nvim",
      main = "ibl",
      opts = {},
    },
  
    -- "gc" to comment visual regions/lines
    { "numToStr/Comment.nvim", opts = {} },
  
    -- Fuzzy Finder (files, lsp, etc)
    {
      "nvim-telescope/telescope.nvim",
      branch = "0.1.x",
      dependencies = {
        "nvim-lua/plenary.nvim",
        -- Fuzzy Finder Algorithm which requires local dependencies to be built.
        -- Only load if `make` is available. Make sure you have the system
        -- requirements installed.
        {
          "nvim-telescope/telescope-fzf-native.nvim",
          -- NOTE: If you are having trouble with this installation,
          --       refer to the README for telescope-fzf-native for more instructions.
          build = "make",
          cond = function()
            return vim.fn.executable("make") == 1
          end,
        },
      },
    },
  
    {
      -- Highlight, edit, and navigate code
      "nvim-treesitter/nvim-treesitter",
      dependencies = {
        "nvim-treesitter/nvim-treesitter-textobjects",
        "nvim-treesitter/nvim-treesitter-context",
      },
      build = ":TSUpdate",
    },
  
    { "mbbill/undotree", config = function() end },
  
    { "christoomey/vim-tmux-navigator", config = function() end },
  
    {
      "windwp/nvim-autopairs",
      opts = {
        fast_wrap = {
          map = "<M-e>",
          chars = { "{", "[", "(", '"', "'" },
          pattern = [=[[%'%"%)%>%]%)%}%,]]=],
          end_key = "$",
          keys = "qwertyuiopzxcvbnmasdfghjkl",
          check_comma = true,
          highlight = "Search",
          highlight_grey = "Comment",
        },
      },
    },
  
    -- NOTE: Next Step on Your Neovim Journey: Add/Configure additional "plugins" for kickstart
    --       These are some example plugins that I've included in the kickstart repository.
    --       Uncomment any of the lines below to enable them.
    -- require 'kickstart.plugins.autoformat',
    -- require 'kickstart.plugins.debug',
  
    -- NOTE: The import below can automatically add your own plugins, configuration, etc from `lua/custom/plugins/*.lua`
    --    You can use this folder to prevent any conflicts with this init.lua if you're interested in keeping
    --    up-to-date with whatever is in the kickstart repo.
    --    Uncomment the following line and add your plugins to `lua/custom/plugins/*.lua` to get going.
    --
    --    For additional information see: https://github.com/folke/lazy.nvim#-structuring-your-plugins
    -- { import = 'custom.plugins' },
  }, {})