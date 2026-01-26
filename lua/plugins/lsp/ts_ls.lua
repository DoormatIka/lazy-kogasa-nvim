local blink = require("blink.cmp")
local lspconfig = require("lspconfig")

local capabilities = blink.get_lsp_capabilities()

lspconfig.ts_ls.setup({
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
