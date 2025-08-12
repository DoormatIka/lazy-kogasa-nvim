
return {
	{
		"nvim-telescope/telescope.nvim",
		dependencies = {
			"nvim-lua/plenary.nvim"
		},
		config = function ()
			local actions = require("telescope.actions")
			require("telescope").setup {
				pickers = {
					find_files = {
						theme = "dropdown"
					},
					help_tags = {
						theme = "dropdown"
					}
				},
				defaults = {
					path_display = { "smart" },
					mappings = {
						n = {
							["<C-d>"] = actions.delete_buffer
						},
						i = {
							["<C-h>"] = "which_key",
							["<C-d>"] = actions.delete_buffer
						}
					}
				}
			}
		end
	},
	{
		"ahmedkhalf/project.nvim",
		config = function ()
			require("project_nvim").setup {
                		manual_mode = true,
                		patterns = { ".nvimproj" }
            		}
            		require("telescope").load_extension("projects")
        	end
	}
}