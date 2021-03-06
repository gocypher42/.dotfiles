local map = require("og.remap").map

-- Use alt + hjkl to resize windows
vim.keymap.set("n", "<M-j>", ":resize -2<CR>")
map("n", "<M-k>", ":resize +2<CR>")
map("n", "<M-h>", ":vertical resize -2<CR>")
map("n", "<M-l>", ":vertical resize +2<CR>")

-- Key binds
-- Remaps to exit insert modeinoremap jk <Esc>
map("i", "ii", "<Esc>")

-- Better tabbing
map("v", "<", "<gv")
map("v", ">", ">gv")

-- Better window navigation
map("n", "<C-h>", "<C-w>h")
map("n", "<C-j>", "<C-w>j")
map("n", "<C-k>", "<C-w>k")
map("n", "<C-l>", "<C-w>l")

-- Add empty new lines
map("n", "<leader>o", "o<Esc>")
map("n", "<leader>O", "O<Esc>")

-- Telescope Mapping
map("n", "<leader>ff", "<cmd>lua require('telescope.builtin').find_files()<cr>")
map("n", "<leader>gf", "<cmd>lua require('telescope.builtin').git_files()<cr>")
map("n", "<leader>fg", "<cmd>lua require('telescope.builtin').live_grep()<cr>")
map("n", "<leader>fb", "<cmd>lua require('telescope.builtin').buffers()<cr>")
map("n", "<leader>fh", "<cmd>lua require('telescope.builtin').help_tags()<cr>")

-- luasnip keybinds
local ls = require("luasnip")
