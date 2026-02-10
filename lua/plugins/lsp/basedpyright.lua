local util = require("lspconfig.util")
local capabilities = require("blink.cmp").get_lsp_capabilities()

vim.lsp.config("basedpyright", {
	capabilities = capabilities,
	root_dir = util.root_pattern("pyproject.toml", ".git"),
	filetypes = {
		"python",
	},
	settings = {
		python = {
			venvPath = ".",
			venv = ".venv",
			analysis = {
				typeCheckingMode = "standard",
				autoSearchPaths = true,
				useLibraryCodeForTypes = true,
			},
		},
	},
})
