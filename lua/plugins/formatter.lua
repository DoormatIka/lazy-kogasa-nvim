return {
	{
		'stevearc/conform.nvim',
		opts = {
			default_format_opts = {
				timeout_ms = 100000,
			},
			formatters_by_ft = {
				javascript = { "prettier" }
			}
		},
	}
}
