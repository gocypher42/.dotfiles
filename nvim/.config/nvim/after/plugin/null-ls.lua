local formatting = require("null-ls").builtins.formatting

local sources = {
    formatting.clang_format.with({
        filetypes = { "cpp", "h", "c" },
        extra_args = {
            "--style={"
                .. "BasedOnStyle: microsoft, "
                .. "ColumnLimit: 80, "
                .. "IndentWidth: 2, "
                .. "DerivePointerAlignment: false, "
                .. "PointerAlignment: Left, "
                .. "ReferenceAlignment: Left, "
                .. "IndentCaseLabels: true"
                .. "}",
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
        extra_args = { "--config", "max_width=80", "--edition", "2021" },
    }),
    formatting.prettier,
}

require("null-ls").setup({
    sources = sources,
})
