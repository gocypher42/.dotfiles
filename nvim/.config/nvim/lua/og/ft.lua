vim.api.nvim_create_autocmd({ "BufEnter", "BufNewFile" }, {
    pattern = { "*.med", "med_*.exp" },
    callback = function()
        vim.opt.filetype = "med"
        vim.opt.syntax = "cpp"
    end,
})
