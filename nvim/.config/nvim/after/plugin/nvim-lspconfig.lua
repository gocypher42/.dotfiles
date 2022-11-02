local make_keybinds = require("og.lsp_keybinds").make_keybinds

-- LSP Native Config
require("nvim-lsp-installer").on_server_ready(function(server)
    local opts = {
        on_attach = function(client)
            make_keybinds()
        end,
        settings = {
            Lua = { diagnostics = { globals = { "vim" } } },
        },
    }
    server:setup(opts)
end)
