-- Treesitter syntax config
local configs = require("nvim-treesitter.configs")

if vim.loop.os_uname().sysname == "Windows_NT" then
	require("nvim-treesitter.install").compilers = { "clang", "gcc" }
end

configs.setup({
	--ensure_installed = "maintained", -- Only use parsers that are maintained
	ensure_installed = "all",
	highlight = {
		enable = true,
	},
	indent = {
		enable = true, -- default is disabled anyways
	},
})
