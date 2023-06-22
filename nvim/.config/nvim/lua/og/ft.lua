vim.api.nvim_create_autocmd({ "BufEnter", "BufNewFile" }, {
    pattern = { "*.med", "med_*.exp" },
    callback = function()
        vim.opt.filetype = "med"
        vim.opt.syntax = "cpp"
    end,
})

vim.api.nvim_create_autocmd({ "BufEnter", "BufNewFile" }, {
    pattern = { "mgate.cfg" },
    callback = function()
        vim.opt.filetype = "xml"
        vim.opt.syntax = "xml"
    end,
})

vim.api.nvim_create_autocmd({ "BufEnter", "BufNewFile" }, {
    pattern = { "*.mxpt" },
    callback = function()
        vim.opt.filetype = "xml"
        vim.opt.syntax = "xml"
    end,
})
