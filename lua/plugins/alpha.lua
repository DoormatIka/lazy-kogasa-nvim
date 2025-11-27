local file = "\u{ea7b}"
local workspaces = "\u{ea83}"
local recent = "\u{e641}"
local quit = "\u{f00d}"

return {
	{
		"goolord/alpha-nvim",
		dependencies = { "nvim-tree/nvim-web-devicons" },
		config = function ()
			local alpha = require("alpha")
			local dashboard = require("alpha.themes.dashboard")
			local version = vim.version()

			local simple = {
				[[ ###################### ]],
				[[   .-^-.        Sealed  ]],
				[[  '"'|`"`        Cloud  ]],
				[[     j           Route  ]],
				[[ ###################### ]],
			}

			dashboard.section.header.val = simple

			dashboard.section.buttons.val = {
				dashboard.button( "e", file .. "  > New file"  , ":ene <BAR> startinsert <CR>"),
				dashboard.button( "w", workspaces .. "  > Workspaces", ":Telescope projects<CR>"),
				dashboard.button( "r", recent .. "  > Recent", ":Telescope oldfiles<CR>"),
				dashboard.button( "q", quit .. "  > Quit NVIM" , ":qa<CR>"),
			}


			dashboard.section.footer.val = {
				"  Kogasa is the best girl of all time.",
				string.format(
					"** Running on Neovim v.%s.%s.%s %s **",
					version.major,
					version.minor,
					version.patch,
					version.api_prerelease and ' (Nightly)' or '(Stable)'
				)
			}

			alpha.setup(dashboard.opts)
		end
	}
}
