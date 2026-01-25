local capabilities = require("blink.cmp").get_lsp_capabilities()
local lspconfig = require("lspconfig")

lspconfig.html.setup({
	capabilities = capabilities,
	on_attach = function(client, bufnr)
		require("workspace-diagnostics").populate_workspace_diagnostics(client, bufnr)
	end,
	init_options = {
		configurationSection = { "html", "css", "javascript" },
		embeddedLanguages = { css = true, javascript = true },
	},
})
