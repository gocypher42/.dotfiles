local mason = require("mason")
local mason_lspconfig = require("mason-lspconfig")
local lspconfig = require("lspconfig")

mason.setup()
mason_lspconfig.setup({
    ensure_installed = {
        "clangd",
        "html",
        "jsonls",
        "omnisharp",
        "lemminx",
        "pyright",
        "rust_analyzer",
        "lua_ls",
        "tsserver",
    },
})

local on_attach = function(client, buffer)
    require("og.lsp_keybinds").make_keybinds(buffer)
    client.server_capabilities.documentFormattingProvider = false
end

lspconfig.lua_ls.setup({
    on_attach = on_attach,
    settings = {
        Lua = { diagnostics = { globals = { "vim" } } },
    },
})
lspconfig.rust_analyzer.setup({ on_attach = on_attach })
lspconfig.pyright.setup({ on_attach = on_attach })
lspconfig.tsserver.setup({ on_attach = on_attach })
lspconfig.omnisharp.setup({
    on_attach = function(client, buffer)
        on_attach(client, buffer)
        vim.api.nvim_buf_set_option(
            buffer,
            "omnifunc",
            "v:lua.vim.lsp.omnifunc"
        )
    end,
})

lspconfig.html.setup({ on_attach = on_attach })
lspconfig.lemminx.setup({ on_attach = on_attach })
lspconfig.powershell_es.setup({ on_attach = on_attach })

require("clangd_extensions").setup({ server = { on_attach = on_attach } })
