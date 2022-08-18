--lsp keymaps
local function make_keybinds()
    vim.keymap.set("n", "K", vim.lsp.buf.hover, { buffer = 0 })
    vim.keymap.set("n", "gd", vim.lsp.buf.definition, { buffer = 0 })
    vim.keymap.set("n", "gt", vim.lsp.buf.type_definition, { buffer = 0 })
    vim.keymap.set("n", "gi", vim.lsp.buf.implementation, { buffer = 0 })
    vim.keymap.set("n", "<leader>dj", vim.diagnostic.goto_next, { buffer = 0 })
    vim.keymap.set("n", "<leader>dk", vim.diagnostic.goto_prev, { buffer = 0 })
    vim.keymap.set(
        "n",
        "<leader>dl",
        "<cmd>Telescope diagnostics<cr>",
        { buffer = 0 }
    )
    vim.keymap.set("n", "<leader>r", vim.lsp.buf.rename, { buffer = 0 })
    vim.keymap.set("n", "<leader>f", vim.lsp.buf.format, { buffer = 0 })
end

-- LSP Native Config
require("nvim-lsp-installer").on_server_ready(function(server)
    local opts = {
        on_attach = function(client)
            -- client.resolved_capabilities.document_formatting = false
            -- client.resolved_capabilities.document_range_formatting = false
            client.server_capabilities.document_formatting = false
            client.server_capabilities.documentFormattingProvider = false
            make_keybinds()
        end,
        settings = {
            Lua = { diagnostics = { globals = { "vim" } } },
        },
    }
    server:setup(opts)
end)
