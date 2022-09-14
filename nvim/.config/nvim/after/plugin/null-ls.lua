local formatting = require("null-ls").builtins.formatting

local sources = {
    formatting.clang_format.with({
        filetypes = { "med" },
        extra_args = {
            "-style={"
                .. "AlignConsecutiveAssignments: AcrossEmptyLinesAndComments"
                .. ", "
                .. "ColumnLimit: 180"
                .. "}",
        },
    }),
    formatting.clang_format.with({
        filetypes = { "java", "cpp" },
        extra_args = { "-style=Google" },
    }),
    formatting.tidy.with({ extra_args = { "-xml", "-i" } }),
    formatting.stylua.with({
        extra_args = { "--column-width", "80", "--indent-type", "Spaces" },
    }),
    formatting.black.with({ extra_args = { "-l", "80" } }),
    formatting.rustfmt.with({
        extra_args = { "--config", "max_width=80" },
    }),
    formatting.prettier,
}

-- Formatter config
require("null-ls").setup({
    sources = sources,
    on_attach = function(client)
        if client.supports_method("textDocument/formatting") then
            vim.keymap.set("n", "<leader>f", function()
                vim.lsp.buf.format()
                print("Document Formated!")
            end, { buffer = 0 })
        end
    end,
})
