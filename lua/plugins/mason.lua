
return {
	{
		"mason-org/mason.nvim",
		lazy = false,
		opts = {}
	},
	{
		"mason-org/mason-lspconfig.nvim",
		lazy = false,
		opts = {
			ensure_installed = { "lua_ls" },
			handlers = {
				function(server_name)
					require("lspconfig")[server_name].setup {}
				end,
				["lua_ls"] = function()
					require("lspconfig").lua_ls.setup {
						settings = {
							Lua = {
								runtime = { version = "LuaJIT" },
								diagnostics = { globals = { "vim" } },
								workspace = {
									library = vim.api.nvim_get_runtime_file("", true),
									checkThirdParty = false,
								},
								telemetry = { enable = false },
							},
						},
					}
				end,
			},
		},
		dependencies = {
			{ "mason-org/mason.nvim", opts = {} },
			"neovim/nvim-lspconfig",
		},
	},
}

