
return {
	{
		"vyfor/cord.nvim",
		build = ":Cord update",
		opts = {
			editor = {
				tooltip = "Kogasa's Neovim",
				icon = "https://raw.githubusercontent.com/DoormatIka/lazy-kogasa-nvim/refs/heads/main/assets/sleepykogasa.png"
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
