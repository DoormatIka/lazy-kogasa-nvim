
return {
	{
		"vyfor/cord.nvim",
		build = ":Cord update",
		opts = {
			editor = {
				tooltip = "Kogasa's Neovim",
				icon = "kogasa_editor"
			},
			display = {
				flavor = "accent"
			},
			text = {
				file_browser = true,
			},
		}
	}
}
