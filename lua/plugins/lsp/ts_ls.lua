local blink = require("blink.cmp")
local lspconfig = require("lspconfig")
local work_diags = require("workspace-diagnostics")

local capabilities = blink.get_lsp_capabilities()

lspconfig.ts_ls.setup({
	capabilities = capabilities,

	on_attach = function(client, bufnr)
		work_diags.populate_workspace_diagnostics(client, bufnr)
	end,
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
