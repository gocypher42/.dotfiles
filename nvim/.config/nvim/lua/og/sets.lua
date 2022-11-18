local global = vim.g

global.mapleader = " "
global.airline_powerline_fonts = 1

local set = vim.opt

set.mouse = ""
set.hidden = true --Enables syntax highlighing
set.wrap = false --Display long lines as just one line
set.encoding = "utf-8" --The encoding displayed
set.pumheight = 10 --Makes popup menu smaller
set.fileencoding = "utf-8" --The encoding written to file
set.ruler = true --Show the cursor position all the time
set.cmdheight = 1 --More space for displaying messages

set.signcolumn = "yes"
set.splitbelow = true --Horizontal splits will automatically be below
set.splitright = true --Vertical splits will automatically be to the right
set.conceallevel = 0 --So that I can see `` in markdown files
set.tabstop = 4 --Insert 2 spaces for a tab
set.shiftwidth = 4 --Change the number of space characters inserted for indentation

set.smarttab = true --Makes tabbing smarter will realize you have 2 vs 4
set.expandtab = true --Converts tabs to spaces
set.smartindent = true --Makes indenting smart
set.autoindent = true --Good auto indent
set.laststatus = 0 --Always display the status line
set.number = true --Line numbers
set.cursorline = true --Enable highlighting of the current line
-- set.background = dark --tell vim what the background color looks like
set.showtabline = 4 --Always show tabs

set.showmode = false --We don't need to see things like -- INSERT -- anymore
set.backup = false
set.swapfile = false
set.writebackup = false
set.updatetime = 300 --Faster completion
set.timeoutlen = 500 --By default timeoutlen is 1000 ms
set.formatoptions.extends = "cro" --Stop newline continution of comments
set.clipboard:append("unnamedplus") --Copy paste between vim and everything else
set.relativenumber = true
set.compatible = false
set.ignorecase = true
set.hlsearch = true
set.incsearch = true
set.cc = "80"
set.cursorline = true

set.ttyfast = true
set.scrolloff = 8
set.showmatch = true
set.hlsearch = false
set.iskeyword.extends = "-" --treat dash separated words as a word text object
