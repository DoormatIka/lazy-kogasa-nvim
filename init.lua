
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
set.relativenumber = true
set.signcolumn = "number"
set.clipboard = ""
set.cursorline = true
set.cursorlineopt = "both"
set.scrolloff = 10

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
vim.g.clipboard = {
    name = "xclip",
    copy = {
        ["+"] = "xclip -selection clipboard",
        ["*"] = "xclip -selection primary",
    },
    paste = {
		["+"] = "xclip -selection clipboard -o",
        ["*"] = "xclip -selection primary -o",
    },
    cache_enabled = 0,
}


-- CLEAN CLRF NEWLINES WTF GIT :sob:
vim.cmd([[command! CleanCLRF :%s/\r$//g]])

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
        underline = true,
        virtual_text = false,
        severity_sort = true,
		float = {
			border = "rounded",
			source = "if_many",
		},
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

local builtin = require("telescope.builtin")
keyset("n", "<leader>ff", builtin.find_files, {})
keyset("n", "<leader>fg", builtin.live_grep,  {})
keyset("n", "<leader>fb", builtin.buffers,    {})
keyset("n", "<leader>fh", builtin.help_tags,  {})
keyset("n", "<leader>fw", function() vim.cmd("Telescope projects") end, {})

keyset("n", "<leader>r", vim.lsp.buf.rename, {})
keyset("n", "<leader>d", vim.lsp.buf.definition, {})

-- move line up and down.
keyset("n", "<A-Up>",   function () vim.cmd("m .-2") end, {})
keyset("n", "<A-Down>", function () vim.cmd("m .+1") end, {})

-- terminal escape.
keyset("t", "<Esc>", "<C-\\><C-n>")
-- diagnostics
api.nvim_create_user_command("Diagnostics", function()
  vim.diagnostic.setqflist()
  vim.cmd("copen 5")
end, {})
api.nvim_create_user_command("Format", function ()
    require("conform").format({ bufnr = vim.api.nvim_get_current_buf() })
end, {})
api.nvim_create_autocmd("DiagnosticChanged", {
	callback = function()
		vim.diagnostic.setqflist({ open = false })
	end,
})

vim.api.nvim_create_autocmd({"CursorHold", "CursorHoldI"},
{
	callback = function()
		vim.diagnostic.open_float(nil, {
			scope = "line",
			close_events = {
				"CursorMoved",
				"CursorMovedI",
				"BufHidden",
				"InsertCharPre",
				"WinLeave",
      		},
			focusable = false,
		})
	end,
})

vim.cmd [[ colorscheme vague ]]
