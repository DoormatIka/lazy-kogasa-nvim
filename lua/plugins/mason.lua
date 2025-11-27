
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
						single_file_support = true,
						filetypes = {
							"typescript",
							"typescriptreact",
							"javascript",
							"javascriptreact",
							"html",
						},
					}
				end,
				["html"] = function()
					local capabilities = vim.lsp.protocol.make_client_capabilities()
					capabilities.textDocument.completion.completionItem.snippetSupport = true
					require("lspconfig").html.setup {
						capabilities = capabilities,
						init_options = {
							configurationSection = { "html", "css", "javascript" },
							embeddedLanguages = { css = true, javascript = true },
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


