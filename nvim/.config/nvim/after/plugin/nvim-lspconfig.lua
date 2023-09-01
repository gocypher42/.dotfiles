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
lspconfig.html.setup({ on_attach = on_attach })
lspconfig.lemminx.setup({ on_attach = on_attach })
lspconfig.powershell_es.setup({ on_attach = on_attach })
lspconfig.jdtls.setup({ on_attach = on_attach })
lspconfig.clangd.setup({
    on_attach = function(client, buffer)
        require("clangd_extensions.inlay_hints").setup_autocmd()
        require("clangd_extensions.inlay_hints").set_inlay_hints()
        on_attach(client, buffer)
    end,
    cmd = {
        "clangd",
        "--enable-config",
        "--clang-tidy",
    },
})

