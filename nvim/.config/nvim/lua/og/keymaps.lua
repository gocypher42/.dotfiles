-- [[ Basic Keymaps ]]

-- Keymaps for better default experience
-- See `:help vim.keymap.set()`
vim.keymap.set({ "n", "v" }, "<Space>", "<Nop>", { silent = true })

-- Remap for dealing with word wrap
vim.keymap.set("n", "k", "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
vim.keymap.set("n", "j", "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

-- Diagnostic keymaps
vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, { desc = "Go to previous diagnostic message" })
vim.keymap.set("n", "]d", vim.diagnostic.goto_next, { desc = "Go to next diagnostic message" })
vim.keymap.set("n", "<leader>e", vim.diagnostic.open_float, { desc = "Open floating diagnostic message" })
vim.keymap.set("n", "<leader>q", vim.diagnostic.setloclist, { desc = "Open diagnostics list" })

-- Rezise windows
vim.keymap.set("n", "<M-j>", ":resize -2<CR>", { desc = "Resize buffer -2 horizontal pixels" })
vim.keymap.set("n", "<M-k>", ":resize +2<CR>", { desc = "Resize buffer +2 horizontal pixels" })
vim.keymap.set("n", "<M-h>", ":vertical resize -2<CR>", { desc = "Resize buffer -2 vertical pixels" })
vim.keymap.set("n", "<M-l>", ":vertical resize +2<CR>", { desc = "Resize buffer +2 vertical pixels" })

-- Better tabbing
vim.keymap.set("v", "<", "<gv", { desc = "Tab to the left" })
vim.keymap.set("v", ">", ">gv", { desc = "Tab to the right" }) -- Better window navigation

-- TmuxNavigate keymaps
vim.keymap.set("n", "<C-h>", "<CMD>TmuxNavigateLeft<CR>", { desc = "TmuxNavigate to window on the left" })
vim.keymap.set("n", "<C-l>", "<CMD>TmuxNavigateRight<CR>", { desc = "TmuxNavigate to window on the right" })
vim.keymap.set("n", "<C-j>", "<CMD>TmuxNavigateDown<CR>", { desc = "TmuxNavigate to window on the bottom" })
vim.keymap.set("n", "<C-k>", "<CMD>TmuxNavigateUp<CR>", { desc = "TmuxNavigate to window on the top" })

-- Move half page but keep curso center
vim.keymap.set("n", "<C-d>", "<C-d>zz", { desc = "Move half a page down and center cursor in the center" })
vim.keymap.set("n", "<C-u>", "<C-u>zz", { desc = "Move half a page up and center cursor in the center" })

-- Better QuickFix
vim.keymap.set("n", "<F9>", "<CMD>cp<CR>zz", { desc = "Go to previous quickfix item" })
vim.keymap.set("n", "<F10>", "<CMD>cn<CR>zz", { desc = "Go to next quickfix item" })
vim.keymap.set("n", "<leader>cc", "<CMD>ccl<CR>", { desc = "Close quickfix list" })

-- undotree
vim.keymap.set("n", "<leader>u", vim.cmd.UndotreeToggle, { desc = "Close quickfix list" })

vim.keymap.set("n", "-", "<CMD>Oil<CR>", { desc = "Open parent directory" })
