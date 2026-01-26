local capabilities = require("blink.cmp").get_lsp_capabilities()
local lspconfig = require("lspconfig")

lspconfig.html.setup({
	capabilities = capabilities,
	init_options = {
		configurationSection = { "html", "css", "javascript" },
		embeddedLanguages = { css = true, javascript = true },
	},
})
