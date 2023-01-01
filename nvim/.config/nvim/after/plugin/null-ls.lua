local formatting = require("null-ls").builtins.formatting

local sources = {
    formatting.clang_format.with({
        filetypes = { "cpp", "h" },
        extra_args = {
            -- "--style={BasedOnStyle: microsoft, ColumnLimit: 80, IndentWidth: 2}",
            "--style={BasedOnStyle: google, ColumnLimit: 80, IndentWidth: 2}",
        },
    }),
    formatting.clang_format.with({
        filetypes = { "java" },
        extra_args = { "-style=Google" },
    }),
    formatting.tidy.with({
        filetypes = { "xml" },
        extra_args = { "-xml", "-i" },
    }),
    formatting.stylua.with({
        extra_args = { "--column-width", "80", "--indent-type", "Spaces" },
    }),
    formatting.black.with({ extra_args = { "-l", "80" } }),
    formatting.rustfmt.with({
        extra_args = { "--config", "max_width=80" },
    }),
    formatting.prettier,
}

-- local lsp_formatting = function(bufnr)
--     vim.lsp.buf.format({
--         filter = function(client)
--             return client.name == "null-ls"
--         end,
--         bufnr = bufnr,
--     })
--
--     print("Document Formated!")
-- end

-- Formatter config
require("null-ls").setup({
    sources = sources,
    -- on_attach = function(client)
    --     if client.supports_method("textDocument/formatting") then
    --         vim.keymap.set("n", "<leader>f", function()
    --             lsp_formatting(0)
    --         end, { buffer = 0 })
    --     end
    -- end,
})
