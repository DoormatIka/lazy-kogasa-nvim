local set = vim.opt_local

vim.lsp.config("qmlls", {
	cmd = { "qmlls" }, -- Mason's qmlls is on PATH once mason.nvim is loaded
	filetypes = { "qml", "qmljs" },
	root_markers = { ".git" },
	init_options = {
		provideFormatter = true,
	},
	settings = {
		qml = {
			format = {
				enable = true,
				tabSize = 2,
				insertSpaces = true,
			},
		},
	},
})
vim.lsp.enable("qmlls")
