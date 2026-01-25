local trouble_keys = {
	{
		"<leader>xx",
		"<cmd>Trouble diagnostics toggle<cr>",
		desc = "Diagnostics (Trouble)",
	},
	{
		"<leader>xQ",
		"<cmd>Trouble qflist toggle<cr>",
		desc = "Quickfix List (Trouble)",
	},
}

local mason_handler = {
	function(server_name)
		local capabilities = require("blink.cmp").get_lsp_capabilities()
		require("lspconfig")[server_name].setup({
			capabilities = capabilities,
			on_attach = function(client, bufnr)
				require("workspace-diagnostics").populate_workspace_diagnostics(client, bufnr)
			end,
		})
	end,
	["lua_ls"] = function()
		require("lsp.lua_ls")
	end,
	["html"] = function()
		require("lsp.html")
	end,
	["tailwindcss"] = function()
		require("lsp.tailwindcss")
	end,
	["ts_ls"] = function()
		require("lsp.ts_ls")
	end,
	["emmet_ls"] = function()
		require("lsp.emmet_ls")
	end,
	["basedpyright"] = function()
		require("lsp.basedpyright")
	end,
}

return {
	{
		"folke/trouble.nvim",
		opts = {},
		cmd = "Trouble",
		keys = trouble_keys,
	},
	{
		"artemave/workspace-diagnostics.nvim",
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
			handlers = mason_handler,
		},
		dependencies = {
			{ "mason-org/mason.nvim", opts = {} },
			"neovim/nvim-lspconfig",
		},
	},
}
