return {
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
					treesitter_highlighting = true,
					draw = function(opts)
						if opts.item and opts.item.documentation and opts.item.documentation.value then
							local out = require("pretty_hover.parser").parse(opts.item.documentation.value)
							opts.item.documentation.value = out:string()
						end

						opts.default_implementation(opts)
					end,
				},
			},
			fuzzy = { implementation = "prefer_rust_with_warning" },
		},
		opts_extend = { "sources.default" },
	},
	{
		"Fildo7525/pretty_hover",
		event = "LspAttach",
		opts = {},
	},
	{
		"mason-org/mason.nvim", -- lsp manager
		lazy = false,
		opts = {},
	},
	{
		"mason-org/mason-lspconfig.nvim", -- nvim-lspconfig to mason between layer
		lazy = false,
		opts = {
			ensure_installed = { "lua_ls", "ts_ls", "emmet_ls", "basedpyright" },
			handlers = {
				function(server_name)
					local capabilities = require("blink.cmp").get_lsp_capabilities()
					require("lspconfig")[server_name].setup({ capabilities = capabilities })
				end,
				["lua_ls"] = function()
					require("lsp.lua_ls")
				end,
				["html"] = function()
					local capabilities = vim.lsp.protocol.make_client_capabilities()
					capabilities.textDocument.completion.completionItem.snippetSupport = true
					require("lspconfig").html.setup({
						capabilities = capabilities,
						init_options = {
							configurationSection = { "html", "css", "javascript" },
							embeddedLanguages = { css = true, javascript = true },
						},
					})
				end,
				["tailwindcss"] = function()
					require("lspconfig").tailwindcss.setup({
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
				end,
				["ts_ls"] = function()
					local capabilities = require("blink.cmp").get_lsp_capabilities()

					require("lspconfig").ts_ls.setup({
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
				end,
				["emmet_ls"] = function()
					require("lspconfig").emmet_ls.setup({
						filetypes = {
							"javascriptreact",
							"typescriptreact",
						},
					})
				end,
				["basedpyright"] = function()
					local lspconfig = require("lspconfig")
					local util = require("lspconfig.util")

					lspconfig.basedpyright.setup({
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
				end,
			},
		},
		dependencies = {
			{ "mason-org/mason.nvim", opts = {} },
			"neovim/nvim-lspconfig",
		},
	},
}
