require("telescope").setup({
    defaults = {
        layout_config = {
            vertical = { width = 0.5 },
        },
        mappings = {
            i = {
                ["<C-h>"] = "which_key",
            },
        },
    },
    pickers = {},
    extensions = {
        fzy_native = {
            override_generic_sorter = false,
            override_file_sorter = true,
        },
        file_browser = {
            theme = "ivy",
            mappings = {
                ["i"] = {},
                ["n"] = {},
            },
        },
    },
})
require("telescope").load_extension("fzy_native")
require("telescope").load_extension("file_browser")

local map = vim.keymap.set
-- Telescope Mapping
map("n", "<leader>ff", "<cmd>lua require('telescope.builtin').find_files()<cr>")
map("n", "<leader>gf", "<cmd>lua require('telescope.builtin').git_files()<cr>")
map("n", "<leader>lg", "<cmd>lua require('telescope.builtin').live_grep()<cr>")
map("n", "<leader>fh", "<cmd>lua require('telescope.builtin').help_tags()<cr>")
map("n", "<leader>gs", "<cmd>Telescope grep_string<cr>")
map("n", "<space>fb", "<cmd>Telescope file_browser<cr>")
