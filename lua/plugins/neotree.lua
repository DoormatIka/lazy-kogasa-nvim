return {
	{
		"nvim-neo-tree/neo-tree.nvim",
		branch = "v3.x",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"MunifTanjim/nui.nvim",
			"nvim-tree/nvim-web-devicons",
		},
		config = function()
			require("neo-tree").setup({
				popup_border_style = "rounded",
				enable_diagnostics = true,
				enable_git_status = true,
				open_files_do_not_replace_types = { "terminal", "trouble", "qf" },
				window = {
					position = "left",
					width = 20,
					mappings = {
						["a"] = {
							"add",
							config = {
								show_path = "relative"
							}
						},
						["d"] = "delete"
					}
				},
				filesystem = {
					use_libuv_file_watcher = false,
					filtered_items = {
						visible = true,
						hide_dotfiles = false,
						hide_gitignored = false
					},
					window = {
						mappings = {
							["<bs>"] = "navigate_up",
							["."] = "set_root"
						}
					}
				}
			})
		end
	},
	{
		"antosha417/nvim-lsp-file-operations",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-neo-tree/neo-tree.nvim", -- makes sure that this loads after Neo-tree.
		},
		config = function()
			require("lsp-file-operations").setup()
		end,
	},
	{
		"s1n7ax/nvim-window-picker",
		version = "2.*",
		config = function()
			require("window-picker").setup({
				filter_rules = {
					include_current_win = false,
					autoselect_one = true,
					-- filter using buffer options
					bo = {
						-- if the file type is one of following, the window will be ignored
						filetype = { "neo-tree", "neo-tree-popup", "notify" },
						-- if the buffer type is one of following, the window will be ignored
						buftype = { "terminal", "quickfix" },
					},
				},
			})
		end,
	}
}
