local make_keybinds = require("og.lsp_keybinds").make_keybinds

require("mason").setup()
require("mason-lspconfig").setup({
    ensure_installed = {
        "clangd",
        "html",
        "jsonls",
        "omnisharp",
        "lemminx",
        "powershell_es",
        "pyright",
        "rust_analyzer",
        "sumneko_lua",
        "tsserver",
    },
})

-- LSP Native Config
require("mason-lspconfig").setup_handlers({
    function(server_name)
        local opts = {
            on_attach = function(client)
                make_keybinds()
            end,
            settings = {
                Lua = { diagnostics = { globals = { "vim" } } },
            },
        }
        require("lspconfig")[server_name].setup({ opts })
    end,
})
