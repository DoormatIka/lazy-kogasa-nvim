
return {
	{
		"mason-org/mason.nvim", -- lsp manager
		lazy = false,
		opts = {}
	},
	{
		"mason-org/mason-lspconfig.nvim", -- nvim-lspconfig to mason between layer
		lazy = false,
		opts = {
			ensure_installed = { "lua_ls", "ts_ls" },
			handlers = {
				function(server_name)
					require("lspconfig")[server_name].setup {}
				end,
				["lua_ls"] = function() require("lsp.lua_ls") end,
				["ts_ls"] = function ()
					require("lspconfig").ts_ls.setup {
						filetypes = { "typescript", "typescriptreact", "javascript", "javascriptreact" },
					}
				end
			},
		},
		dependencies = {
			{ "mason-org/mason.nvim", opts = {} },
			"neovim/nvim-lspconfig",
		},
	},
	{
		"saghen/blink.cmp", -- completion helper
		dependencies = { "rafamadriz/friendly-snippets" },
		version = "1.*",
		opts = {
			keymap = {
				preset = "super-tab",
			},
			appearance = {
				nerd_font_variant = "mono",
			},
			sources = {
				default = { "lsp", "path", "snippets", "buffer" },
			},
			completion = {
				documentation = {
					auto_show = true,
					treesitter_highlighting = false,
				}
			},
			fuzzy = { implementation = "prefer_rust_with_warning" },
		},
		opts_extend = { "sources.default" }
	},
}


