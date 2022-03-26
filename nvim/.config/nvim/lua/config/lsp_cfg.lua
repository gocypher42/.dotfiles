local capabilities = require("cmp_nvim_lsp").update_capabilities(
	vim.lsp.protocol.make_client_capabilities()
)

-- LSP Native Config
local lsp_installer = require("nvim-lsp-installer")
lsp_installer.on_server_ready(function(server)
	local opts = {
		capabilities = capabilities,
		on_attach = function(client)
			client.resolved_capabilities.document_formatting = false
			client.resolved_capabilities.document_range_formatting = false
			vim.keymap.set("n", "K", vim.lsp.buf.hover, { buffer = 0 })
			vim.keymap.set("n", "gd", vim.lsp.buf.definition, { buffer = 0 })
			vim.keymap.set(
				"n",
				"gt",
				vim.lsp.buf.type_definition,
				{ buffer = 0 }
			)
			vim.keymap.set(
				"n",
				"gi",
				vim.lsp.buf.implementation,
				{ buffer = 0 }
			)
			vim.keymap.set(
				"n",
				"<leader>dj",
				vim.diagnostic.goto_next,
				{ buffer = 0 }
			)
			vim.keymap.set(
				"n",
				"<leader>dk",
				vim.diagnostic.goto_prev,
				{ buffer = 0 }
			)
			vim.keymap.set(
				"n",
				"<leader>dl",
				"<cmd>Telescope diagnostics<cr>",
				{ buffer = 0 }
			)
			vim.keymap.set("n", "<leader>r", vim.lsp.buf.rename, { buffer = 0 })
			vim.keymap.set(
				"n",
				"<leader>f",
				vim.lsp.buf.formatting,
				{ buffer = 0 }
			)
		end,
	}
	server:setup(opts)
end)

-- vim-cmp Config
vim.opt.completeopt = { "menu", "menuone", "noselect" } -- setting vim options

-- Setup nvim-cmp.
local has_words_before = function()
	local line, col = unpack(vim.api.nvim_win_get_cursor(0))
	return col ~= 0
		and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]
				:sub(col, col)
				:match("%s")
			== nil
end

local luasnip = require("luasnip")
local cmp = require("cmp")

cmp.setup({
	snippet = {
		expand = function(args)
			require("luasnip").lsp_expand(args.body) -- For `luasnip` users.
		end,
	},
	mapping = {
		["<C-b>"] = cmp.mapping(cmp.mapping.scroll_docs(-4), { "i", "c" }),
		["<C-f>"] = cmp.mapping(cmp.mapping.scroll_docs(4), { "i", "c" }),
		["<C-Space>"] = cmp.mapping(cmp.mapping.complete(), { "i", "c" }),
		["<C-y>"] = cmp.config.disable, -- Specify `cmp.config.disable` if you want to remove the default `<C-y>` mapping.
		["<C-e>"] = cmp.mapping({
			i = cmp.mapping.abort(),
			c = cmp.mapping.close(),
		}),
		["<CR>"] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
		["<Tab>"] = cmp.mapping(function(fallback)
			if cmp.visible() then
				cmp.select_next_item()
			elseif luasnip.expand_or_jumpable() then
				luasnip.expand_or_jump()
			elseif has_words_before() then
				cmp.complete()
			else
				fallback()
			end
		end, { "i", "s" }),

		["<S-Tab>"] = cmp.mapping(function(fallback)
			if cmp.visible() then
				cmp.select_prev_item()
			elseif luasnip.jumpable(-1) then
				luasnip.jump(-1)
			else
				fallback()
			end
		end, { "i", "s" }),
	},
	sources = cmp.config.sources({
		{ name = "nvim_lsp" },
		{ name = "luasnip" }, -- For luasnip users.
	}, {
		{ name = "buffer" },
	}),
})
