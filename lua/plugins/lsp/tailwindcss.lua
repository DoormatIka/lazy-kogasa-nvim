local blink = require("blink.cmp")
local lspconfig = require("lspconfig")
local work_diags = require("workspace-diagnostics")

local capabilities = blink.get_lsp_capabilities()
lspconfig.tailwindcss.setup({
	capabilities = capabilities,
	on_attach = function(client, bufnr)
		work_diags.populate_workspace_diagnostics(client, bufnr)
	end,
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
