
local set = vim.opt
local api = vim.api
local keyset = vim.keymap.set
local global = vim.g
vim.loader.enable()

set.ft = "xxd"
set.updatetime = 300
set.shiftwidth = 4
set.tabstop = 4
set.expandtab = false
set.number = true
set.clipboard = ""
set.cursorline = true
set.cursorlineopt = "both"

-- clipboard, only syncs with sys clipboard when you tab out
api.nvim_create_autocmd("FocusGained", {
	pattern = { "*" },
	command = [[call setreg("@", getreg("+"))]],
})
api.nvim_create_autocmd("FocusLost", {
	pattern = { "*" },
	command = [[call setreg("+", getreg("@"))]],
})

vim.opt.termguicolors = true
vim.wo.wrap = false
vim.wo.linebreak = false

global.mapleader = ","
set.pyxversion = 3
global.clipboard = {
	['name'] = 'WslClipboard',
  	['copy'] = {
    	["+"] = 'clip.exe',
    	["*"] = 'clip.exe',
  	},
	['paste'] = {
		['+'] = 'powershell.exe -c [Console]::Out.Write($(Get-Clipboard -Raw).replace("`r", ""))',
		['*'] = 'powershell.exe -c [Console]::Out.Write($(Get-Clipboard -Raw).replace("`r", ""))',
	},
	['cache_enabled'] = 0,
}

-- plugins
require("config.lazy")
require("lazy").setup({
	spec = {
		-- import your plugins
		{ import = "plugins" },
	},
	-- Configure any other settings here. See the documentation for more details.
	-- colorscheme that will be used when installing plugins.
	-- automatically check for plugin updates
	checker = { enabled = true },
})

-- diagnostics

vim.diagnostic.config(
    {
        underline = false,
        virtual_text = {
            spacing = 2,
        },
        update_in_insert = false,
        severity_sort = true,
        signs = {
            text = {
                [vim.diagnostic.severity.ERROR] = "\u{2718}",
                [vim.diagnostic.severity.WARN] = "\u{25B2}",
                [vim.diagnostic.severity.HINT] = "\u{2691}",
                [vim.diagnostic.severity.INFO] = "\u{F129}",
            },
        },
    }
)

-- keys
keyset("n", "<leader>c", function() vim.cmd("tabnew") end, {})
keyset("n", "<leader>.", function() vim.cmd("tabn") end, {})
keyset("n", "<leader>m", function() vim.cmd("tabp") end, {})
keyset("n", "<leader>x", function() vim.cmd("tabclose") end, {})
keyset("n", "<leader>;", function() vim.cmd("Neotree position=float") end, {})
keyset("n", "<leader>fw", function() vim.cmd("Telescope projects") end, {})

vim.cmd [[ colorscheme gruvbox ]]
