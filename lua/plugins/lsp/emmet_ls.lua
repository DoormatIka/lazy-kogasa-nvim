local capabilities = require("blink.cmp").get_lsp_capabilities()
require("lspconfig").emmet_ls.setup({
	capabilities = capabilities,
	filetypes = {
		"javascriptreact",
		"typescriptreact",
	},
})
