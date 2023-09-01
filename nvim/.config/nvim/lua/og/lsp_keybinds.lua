--lsp keymaps
local M = {}
local map = vim.keymap.set
local telescope = require("telescope.builtin")

M.make_keybinds = function(buffer)
    local opts = { buffer = buffer }
    map("n", "<leader>ca", vim.lsp.buf.code_action, opts)
    map("n", "K", vim.lsp.buf.hover, opts)
    map("n", "<leader>gt", vim.lsp.buf.type_definition, opts)
    map("n", "<leader>dj", vim.diagnostic.goto_next, opts)
    map("n", "<leader>dk", vim.diagnostic.goto_prev, opts)
    map("n", "<leader>r", vim.lsp.buf.rename, opts)
    map("n", "<leader>f", vim.lsp.buf.format, opts)

    map("n", "<leader>gi", telescope.lsp_implementations, opts)
    map("n", "<leader>dl", telescope.diagnostics, opts)
    map("n", "<leader>gd", telescope.lsp_definitions, opts)
    map("n", "<leader>gr", telescope.lsp_references, opts)
end

return M
