local blink = require("blink.cmp")
local lspconfig = require("lspconfig")

local capabilities = blink.get_lsp_capabilities()
lspconfig.tailwindcss.setup({
	capabilities = capabilities,
	root_dir = lspconfig.util.root_pattern(
		"tailwind.config.js",
		"tailwind.config.ts",
		"postcss.config.js",
		"package.json",
		"node_modules",
		".git"
	),
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
