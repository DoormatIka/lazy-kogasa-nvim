local blink = require("blink.cmp")

local capabilities = blink.get_lsp_capabilities()

vim.lsp.config("ts_ls", {
	capabilities = capabilities,
	single_file_support = true,
	filetypes = {
		"typescript",
		"typescriptreact",
		"javascript",
		"javascriptreact",
		"html",
	},
	init_options = {
		preferences = {
			includeCompletionsForImportStatements = true,
			includeCompletionsWithSnippetText = true,
			includeAutomaticOptionalChainCompletions = true,
			includeCompletionsForModuleExports = true,
		},
	},
})
