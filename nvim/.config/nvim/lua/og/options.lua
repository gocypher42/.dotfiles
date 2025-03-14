-- [[ Setting options ]]
-- See `:help vim.o`
-- NOTE: You can change these options as you wish!

-- Set highlight on search
vim.o.hlsearch = false
if (vim.loop.os_uname().sysname == "Windows_NT") then
  vim.g.undotree_DiffCommand = "fc"
end

-- Make line numbers default
vim.wo.number = true

-- Enable mouse mode
vim.o.mouse = ""

-- Sync clipboard between OS and Neovim.
--  Remove this option if you want your OS clipboard to remain independent.
--  See `:help 'clipboard'`
vim.o.clipboard = "unnamedplus"

-- Enable break indent
vim.o.breakindent = true

-- Save undo history
vim.o.undofile = true
vim.o.swapfile = false
vim.o.backup = false
vim.o.undodir = vim.fn.expand("~") .. "/.vim/undodir"

-- Case-insensitive searching UNLESS \C or capital in search
vim.o.ignorecase = true
vim.o.smartcase = true

-- Keep signcolumn on by default
vim.wo.signcolumn = "yes"

-- Decrease update time
vim.o.updatetime = 250
vim.o.timeoutlen = 300

-- Set completeopt to have a better completion experience
vim.o.completeopt = "menuone,noselect"

-- NOTE: You should make sure your terminal supports this
vim.o.termguicolors = true

vim.o.splitbelow = true
vim.o.splitright = true
vim.o.cc = "80"
vim.o.cursorline = true
vim.o.scrolloff = 8
vim.o.compatible = false
vim.o.wrap = false
vim.o.relativenumber = true

-- NOTE: Add new filetype
vim.filetype.add({
  extension = {
    CPP = "cpp"
  },
  filename = {},
  pattern = {}
})
