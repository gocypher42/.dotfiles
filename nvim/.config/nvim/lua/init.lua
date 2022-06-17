-- Direct import
require("Comment").setup()

-- Custom Configs
require("config.lsp_cfg")
require("config.treesitter_cfg")
require("config.telescope_cfg")
require("config.null-lsp_cfg")

require("plenary.filetype").add_file("med")
