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

local mason_lspconfig = require("mason-lspconfig")
local lspconfig = require("lspconfig")

-- LSP Native Config
mason_lspconfig.setup_handlers({
    function(server_name)
        lspconfig[server_name].setup({
            on_attach = function(client)
                make_keybinds()
            end,
            settings = {
                Lua = { diagnostics = { globals = { "vim" } } },
            },
        })
    end,
})
