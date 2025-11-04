return {
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
			require("nvim-treesitter.configs").setup {
				ensure_installed = {
					"lua",
					"vim",
					"javascript",
					"typescript",
					"vimdoc",
					"luadoc",
					"markdown"
				},
				auto_install = true,
				sync_install = false,
				highlight = {
					enable = true,
					disable = function(lang, buf)
						local max_filesize = 100 * 1024 -- 100 KB
						local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
						if ok and stats and stats.size > max_filesize then
							return true
						end
					end,
					additional_vim_regex_highlighting = false,
				}
			}
		end
	}
}
