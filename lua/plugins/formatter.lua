return {
	{
		"stevearc/conform.nvim",
		event = { "BufWritePre" },
		opts = {
			default_format_opts = {
				timeout_ms = 100000,
			},
			formatters_by_ft = {
				javascript = { "prettierd" },
				typescript = { "prettierd" },
				javascriptreact = { "prettierd" },
				typescriptreact = { "prettierd" },
				css = { "prettierd" },
				html = { "prettierd" },
				json = { "prettierd" },
				yaml = { "prettierd" },
				markdown = { "prettierd" },
				lua = { "stylua" },
				cs = { "csharpier" },
			},
			format_on_save = {
				timeout_ms = 5000,
				interval_ms = 50,
				async = false,
			},
		},
	},
}
