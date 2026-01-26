local blink = require("blink.cmp")
local lspconfig = require("lspconfig")

local capabilities = blink.get_lsp_capabilities()
lspconfig.tailwindcss.setup({
	capabilities = capabilities,
	filetypes = {
		"typescript",
		"typescriptreact",
		"javascript",
		"javascriptreact",
		"html",
		"css",
		"vue",
		"svelte",
	},
})
