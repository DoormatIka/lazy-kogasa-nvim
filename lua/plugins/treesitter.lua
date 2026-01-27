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
local incremental_selection = {
	enable = true,
	keymaps = {
		init_selection = "gnn",
		node_incremental = "grn",
		node_decremental = "grm",
		scope_incremental = "grc",
	},
}

return {
	{
		"nvim-treesitter/nvim-treesitter-textobjects",
		dependencies = { "nvim-treesitter/nvim-treesitter" },
		config = function()
			require("nvim-treesitter.configs").setup({
				ensure_installed = {
					"lua",
					"vim",
					"javascript",
					"typescript",
					"vimdoc",
					"luadoc",
					"markdown",
				},
				indent = { enable = true },
				incremental_selection = incremental_selection,
				auto_install = true,
				sync_install = false,
				highlight = {
					enable = true,
					disable = function(_, buf)
						local max_filesize = 100 * 1024 -- 100 KB
						local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
						if ok and stats and stats.size > max_filesize then
							return true
						end
					end,
					additional_vim_regex_highlighting = false,
				},
				textobjects = textobjects,
			})
		end,
	},
	{
		"nvim-treesitter/nvim-treesitter",
		lazy = false,
		build = function()
			local ts_update = require("nvim-treesitter.install").update({ with_sync = true })
			ts_update()
		end,
		config = function()
			require("nvim-treesitter.install").prefer_git = false
			require("nvim-treesitter.install").compilers = { "clang" }
		end,
	},
}
