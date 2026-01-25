local capabilities = require("blink.cmp").get_lsp_capabilities()
require("lspconfig").emmet_ls.setup({
	capabilities = capabilities,
	on_attach = function(client, bufnr)
		require("workspace-diagnostics").populate_workspace_diagnostics(client, bufnr)
	end,
	filetypes = {
		"javascriptreact",
		"typescriptreact",
	},
})
