local map = vim.keymap.set

-- Use alt + hjkl to resize windows
map("n", "<M-j>", ":resize -2<CR>")
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
map("n", "<C-h>", "<CMD>TmuxNavigateLeft")
map("n", "<C-j>", "<C-w>TmuxNavigateLeft")
map("n", "<C-k>", "<C-w>TmuxNavigateLeft")
map("n", "<C-l>", "<C-w>TmuxNavigateLeft")

-- Add empty new lines
map("n", "<leader>o", "o<Esc>")
map("n", "<leader>O", "O<Esc>")

-- Move half page but keep curso center
map("n", "<C-d>", "<C-d>zz")
map("n", "<C-u>", "<C-u>zz")

map("n", "<leader>x", "<CMD>Ex<CR>")

-- BufferLine 
map("n", "<F8>", "<CMD>BufferLineCycleNext<CR>")
map("n", "<F7>", "<CMD>BufferLineCyclePrev<CR>")
map("n", "<leader>w", "<CMD>BufferLinePickClose<CR>")
