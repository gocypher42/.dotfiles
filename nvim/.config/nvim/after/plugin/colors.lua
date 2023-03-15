-- require("onedark").setup({
--     transparent = true,
-- })

-- vim.cmd([[colorscheme gruvbox]])
vim.cmd([[colorscheme dracula]])

local dracula = require("dracula")
dracula.setup({
    transparent_bg = true, -- default false
})
