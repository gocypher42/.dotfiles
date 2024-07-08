-- Set <space> as the leader key
-- See `:help mapleader`
--  NOTE: Must happen before plugins are required (otherwise wrong leader will be used)
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- [[ Install `lazy.nvim` plugin manager ]]
--    https://github.com/folke/lazy.nvim
--    `:help lazy.nvim.txt` for more info
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

require("og.plugins")
require("og.options")
require("og.keymaps")

-- [[ Highlight on yank ]]
-- See `:help vim.highlight.on_yank()`
local highlight_group = vim.api.nvim_create_augroup("YankHighlight", { clear = true })
vim.api.nvim_create_autocmd("TextYankPost", {
  callback = function()
    vim.highlight.on_yank()
  end,
  group = highlight_group,
  pattern = "*",
})

-- The line beneath this is called `modeline`. See `:help modeline`
-- vim: ts=2 sts=2 sw=2 et
--
local augroup = vim.api.nvim_create_augroup
local og_group = augroup("og", {})

-- [[ file types ]]
vim.api.nvim_create_autocmd({ "BufEnter", "BufNewFile" }, {
  group = og_group,
  pattern = { "*.med", "med_*.exp" },
  callback = function()
    vim.opt.filetype = "med"
    vim.opt.syntax = "cpp"
  end,
})

vim.api.nvim_create_autocmd({ "BufEnter", "BufNewFile" }, {
  group = og_group,
  pattern = { "mgate.cfg" },
  callback = function()
    vim.opt.filetype = "xml"
    vim.opt.syntax = "xml"
  end,
})

vim.api.nvim_create_autocmd({ "BufEnter", "BufNewFile" }, {
  group = og_group,
  pattern = { "*.mxpt" },
  callback = function()
    vim.opt.filetype = "xml"
    vim.opt.syntax = "xml"
  end,
})

require("og.marcotte")
if not is_marcotte_computer() then
  vim.api.nvim_create_autocmd({ "BufWritePre" }, {
    group = og_group,
    pattern = { "*" },
    command = [[%s/\s\+$//e]],
  })
end
