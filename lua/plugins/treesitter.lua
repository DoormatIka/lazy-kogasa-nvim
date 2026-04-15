local textobjects = {
	move = {
		enable = true,
		goto_next_start = {
			["]f"] = "@function.inner",
			["]c"] = "@class.inner",
			["]b"] = "@block.inner",
			["]s"] = "@scope",
		},
		goto_previous_start = {
			["[f"] = "@function.inner",
			["[c"] = "@class.inner",
			["[b"] = "@block.inner",
			["[s"] = "@scope",
		},
	},
	select = {
		enable = true,
		keymaps = {
			["af"] = "@function.outer",
			["if"] = "@function.inner",
			["ac"] = "@class.outer",
			["ic"] = "@class.inner",
			["as"] = "@scope.outer",
			["is"] = "@scope.inner",
		},
	},
}

return {
	{
		"nvim-treesitter/nvim-treesitter-textobjects",
		dependencies = { "nvim-treesitter/nvim-treesitter" },
		config = function()
			require("nvim-treesitter-textobjects").setup({
				textobjects = textobjects,
			})
		end,
	},
	{
		"romus204/tree-sitter-manager.nvim",
		dependencies = {}, -- tree-sitter CLI must be installed system-wide
		config = function()
			require("tree-sitter-manager").setup({
				ensure_installed = {
					"svelte",
					"html",
					"css",
					"typescript",
					"javascript",
					"rust",
				}, -- list of parsers to install at the start of a neovim session
				auto_install = true, -- if enabled, install missing parsers when editing a new file
				highlight = true, -- treesitter highlighting is enabled by default
			})
		end,
	},
	{
		"nvim-treesitter/nvim-treesitter",
		branch = "main", -- the new rewrite
		lazy = false,
		build = ":TSUpdate",
		config = function()
			require("nvim-treesitter").setup({})

			-- Remap built-in 0.12 treesitter selection to your preferred keys
			vim.keymap.set("n", "gnn", "van", { remap = true, desc = "Init treesitter selection" })
			vim.keymap.set("x", "grn", "an", { remap = true, desc = "Expand treesitter node" })
			vim.keymap.set("x", "grm", "]n", { remap = true, desc = "Shrink treesitter node" })

			-- Enable highlighting per filetype (new API)
			vim.api.nvim_create_autocmd("FileType", {
				callback = function(args)
					local max_filesize = 100 * 1024
					local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(args.buf))
					if ok and stats and stats.size > max_filesize then
						return
					end
					pcall(vim.treesitter.start)
				end,
			})
		end,
	},
}
