if vim.loop.os_uname().sysname == "Windows_NT" then
    require("nvim-treesitter.install").compilers = { "clang", "gcc" }
end

require("nvim-treesitter.configs").setup({
    ensure_installed = "all",
    -- Automatically install missing parsers when entering buffer
    -- auto_install = true,

    -- List of parsers to ignore installing (for "all")
    ignore_install = { "starlark", "rnoweb", "norg", "fortran" },

    highlight = {
        -- `false` will disable the whole extension
        enable = true,
    },
    indent = {
        enable = true,
    },
})
