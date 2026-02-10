local capabilities = require("blink.cmp").get_lsp_capabilities()

local runtime_path = vim.split(package.path, ";")
table.insert(runtime_path, "lua/?.lua")
table.insert(runtime_path, "lua/?/init.lua")

vim.lsp.config("lua_ls", {
	capabilities = capabilities,
	on_attach = function(client, bufnr)
		require("workspace-diagnostics").populate_workspace_diagnostics(client, bufnr)
	end,
	settings = {
		Lua = {
			runtime = {
				version = "LuaJIT",
				path = runtime_path,
			},
			diagnostics = {
				globals = { "vim" },
				disable = { "missing-fields" },
			},
			workspace = {
				library = {
					vim.fn.expand("$VIMRUNTIME/lua"),
					vim.fn.expand("$VIMRUNTIME/lua/vim/lsp"),
					vim.fn.stdpath("data") .. "/lazy/lazy.nvim/lua/lazy",
				},
				maxPreload = 100000,
				preloadFileSize = 10000,
				checkThirdParty = false,
			},
			telemetry = { enable = false },
			hint = { enable = true },
			format = { enable = false },
		},
	},
})
