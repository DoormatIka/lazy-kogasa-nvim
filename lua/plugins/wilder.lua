return {
		"gelguy/wilder.nvim",
		dependencies = { 
			"nvim-tree/nvim-web-devicons",
			"romgrk/fzy-lua-native"
		},
		config = function ()
			local wilder = require("wilder")
			wilder.set_option('renderer',
			wilder.popupmenu_renderer(
				wilder.popupmenu_border_theme({
					highlights = { border = "Normal" },
					empty_message = wilder.popupmenu_empty_message_with_spinner({
						message = "Can't find anything! "
					}),
					border = "double",
					left = { " ", wilder.popupmenu_devicons() },
					right = { " ", wilder.popupmenu_scrollbar() },
					highlighter = {
						wilder.pcre2_highlighter(),
						wilder.lua_fzy_highlighter(),
					}
				})
			)
		)
		wilder.setup({
			modes = { ":", "/", "?" }
		})
	end,
}