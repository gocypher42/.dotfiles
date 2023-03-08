require("bufferline").setup({
    options = {
        buffer_close_icon = "",
        close_icon = "",
        diagnostics = "nvim_lsp",
        diagnostics_indicator = function(count, level, _, _)
            local icon = level:match("error") and " " or " "
            return " " .. icon .. count
        end,
        indicator = {
            icon = "|",
            style = "underline",
        },
        offsets = {
            {
                filetype = "NvimTree",
                text = "File Explorer",
                highlight = "Directory",
                separator = true, -- use a "true" to enable the default, or set your own character
            },
            {
                filetype = "undotree",
                text = "Undo Tree",
                separator = true, -- use a "true" to enable the default, or set your own character
            },
        },
    },
})
