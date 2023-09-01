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

-- Marcotte specific commands
local function GetFileExtension(url)
    return url:match("^.+(%..+)$")
end

local function get_exe_name(cpp_filename)
    local ext = GetFileExtension(cpp_filename)
    if ext ~= ".cpp" then
        return ""
    end
    return string.sub(cpp_filename, 0, string.len(cpp_filename) - 4) .. ".exe"
end

local function marcotte_compile()
    local exe = get_exe_name(vim.fn.expand("%"))
    os.remove(exe)
    vim.cmd("w")
    vim.cmd("!cmd /c compile exe %")
end

local function marcotte_run()
    local filename = vim.fn.expand("%")
    local exe = get_exe_name(filename)
    vim.cmd("!" .. exe)
end

local function marcotte_all()
    marcotte_compile()
    marcotte_run()
end

map("n", "<leader>mc", marcotte_compile)
map("n", "<leader>mr", marcotte_run)
map("n", "<leader>ma", marcotte_all)
