local formatting = require("null-ls").builtins.formatting
-- Formatter config
require("null-ls").setup({
	debug = true,
	sources = {
		formatting.tidy.with({
                	filetypes = { "xml" },
			extra_args = { "-xml", "-i" },
             	}),
		formatting.stylua.with({ extra_args = { "--column-width", "80" } }),
		formatting.black.with({ extra_args = { "-l", "80" } }),
		formatting.rustfmt.with({
			extra_args = { "--config", "max_width=80" },
		}),
	},
	on_attach = function(client) -- Format on save
		if client.resolved_capabilities.document_formatting then
			vim.cmd([[
            augroup LspFormatting
                autocmd! * <buffer>
                autocmd BufWritePre <buffer> lua vim.lsp.buf.formatting_sync()
            augroup END
            ]])
		end
	end,
})
