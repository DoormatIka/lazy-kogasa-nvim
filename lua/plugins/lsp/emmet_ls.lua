local capabilities = require("blink.cmp").get_lsp_capabilities()

vim.lsp.config("emmet_ls", {
	capabilities = capabilities,
	filetypes = {
		"javascriptreact",
		"typescriptreact",
	},
})
