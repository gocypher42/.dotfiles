require("lualine").setup({
    options = {
        theme = "dracula-nvim",
    },
    sections = {
        lualine_c = {
            {
                "filename",
                path = 2,
            },
        },
    },
})
