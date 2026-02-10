local capabilities = require("blink.cmp").get_lsp_capabilities()

vim.lsp.config("html", {
	capabilities = capabilities,
	init_options = {
		configurationSection = { "html", "css", "javascript" },
		embeddedLanguages = { css = true, javascript = true },
	},
})
