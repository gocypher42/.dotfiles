-- Treesitter syntax config
local configs = require("nvim-treesitter.configs")
configs.setup({
	ensure_installed = "maintained", -- Only use parsers that are maintained
	highlight = {
		enable = true,
	},
	indent = {
		enable = true, -- default is disabled anyways
	},
})
