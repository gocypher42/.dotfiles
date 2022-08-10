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
    vim.keymap.set("n", "<leader>f", vim.lsp.buf.formatting, { buffer = 0 })
end

-- LSP Native Config
require("nvim-lsp-installer").on_server_ready(function(server)
    local opts = {
        on_attach = function(client)
            -- client.resolved_capabilities.document_formatting = false
            -- client.resolved_capabilities.document_range_formatting = false
            client.server_capabilities.document_formatting = false
            client.server_capabilities.document_range_formatting = false
            make_keybinds()
        end,
        settings = {
            Lua = { diagnostics = { globals = { "vim" } } },
        },
    }
    server:setup(opts)
end)

local luasnip = require("luasnip")
local cmp = require("cmp")

cmp.setup({
    snippet = {
        expand = function(args)
            luasnip.lsp_expand(args.body) -- For `luasnip` users.
        end,
    },
    mapping = cmp.mapping.preset.insert({
        ["<C-d>"] = cmp.mapping.scroll_docs(-4),
        ["<C-f>"] = cmp.mapping.scroll_docs(4),
        ["<C-Space>"] = cmp.mapping.complete(),
        ["<CR>"] = cmp.mapping.confirm({
            behavior = cmp.ConfirmBehavior.Replace,
            select = true,
        }),
        ["<Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
                cmp.select_next_item()
            elseif luasnip.expand_or_jumpable() then
                luasnip.expand_or_jump()
            else
                fallback()
            end
        end, { "i", "s" }),
        ["<S-Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
                cmp.select_prev_item()
            elseif luasnip.jumpable(-1) then
                luasnip.jump(-1)
            else
                fallback()
            end
        end, { "i", "s" }),
    }),
    sources = {
        { name = "nvim_lua" },
        { name = "nvim_lsp" },
        { name = "luasnip" }, -- For luasnip users.
        { name = "buffer", keyword_length = 5 },
    },
    experimental = {
        ghost_text = true,
    },
})
