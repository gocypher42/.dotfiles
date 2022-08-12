local formatting = require("null-ls").builtins.formatting
local augroup = vim.api.nvim_create_augroup("LspFormatting", {})

local sources = {
    formatting.clang_format.with({
        filetypes = { "cpp" },
        extra_args = {
            "-style={AlignConsecutiveAssignments: AcrossEmptyLinesAndComments, ColumnLimit: 180}",
        },
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
    on_attach = function(client, bufnr)
        if client.supports_method("textDocument/formatting") then
            vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
            vim.api.nvim_create_autocmd("BufWritePre", {
                group = augroup,
                buffer = bufnr,
                callback = function()
                    vim.lsp.buf.format({ bufnr = bufnr })
                end,
            })
        end
    end,
})
