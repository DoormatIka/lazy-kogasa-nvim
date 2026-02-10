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
set.signcolumn = "auto"
set.clipboard = ""
set.cursorline = true
set.cursorlineopt = "both"
set.scrolloff = 10

local clipboard_augroup = vim.api.nvim_create_augroup("Clipboard", { clear = true })
local diagnostics_augroup = vim.api.nvim_create_augroup("Diagnostics", { clear = true })

-- clipboard, only syncs with sys clipboard when you tab out
api.nvim_create_autocmd("FocusGained", {
	group = clipboard_augroup,
	pattern = { "*" },
	command = [[call setreg("@", getreg("+"))]],
})
api.nvim_create_autocmd("FocusLost", {
	group = clipboard_augroup,
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
vim.diagnostic.config({
	underline = true,
	virtual_text = false,
	severity_sort = true,
	float = {
		border = "rounded",
		source = "if_many",
	},
	signs = {
		text = {
			[vim.diagnostic.severity.ERROR] = "",
			[vim.diagnostic.severity.WARN] = "",
			[vim.diagnostic.severity.INFO] = "",
			[vim.diagnostic.severity.HINT] = "",
		},
		linehl = {
			[vim.diagnostic.severity.ERROR] = "DiagnosticLineError",
			[vim.diagnostic.severity.WARN] = "DiagnosticLineWarn",
			[vim.diagnostic.severity.HINT] = "DiagnosticLineInfo",
			[vim.diagnostic.severity.INFO] = "DiagnosticLineInfo",
		},
	},
})

-- keys
--[[
keyset("n", "<leader>c", function()
	vim.cmd("tabnew")
end, {})
]]
local barbar_opts = { noremap = true, silent = true }

keyset("n", "<leader>m", "<Cmd>BufferPrevious<CR>", barbar_opts)
keyset("n", "<leader>.", "<Cmd>BufferNext<CR>", barbar_opts)
keyset("n", "<leader>x", "<Cmd>BufferClose<CR>", barbar_opts)
keyset("n", "<leader>bd", "<Cmd>BufferOrderByDirectory<CR>", barbar_opts)

keyset("n", "<leader>;", function()
	vim.cmd("Neotree position=float")
end, {})

local builtin = require("telescope.builtin")
keyset("n", "<leader>ff", builtin.find_files, {})
keyset("n", "<leader>fg", builtin.live_grep, {})
keyset("n", "<leader>fb", builtin.buffers, {})
keyset("n", "<leader>fh", builtin.help_tags, {})
keyset("n", "<leader>fw", function()
	vim.cmd("Telescope projects")
end, {})

keyset("n", "<leader>rn", vim.lsp.buf.rename, {})
keyset("n", "<leader>gd", function()
	vim.cmd("split")
	vim.lsp.buf.definition()
end, {})

-- move line up and down.
-- `==` - first = is for fixing indents, second = is to do this in the current line.
-- 		- verb (operator) + noun (motion) = action
keyset("n", "<A-Up>", ":m .-2<CR>==", {})
keyset("n", "<A-Down>", ":m .+1<CR>==", {})
-- `x`    - visual mode
-- `gv`   - reselects the text that was recently in visual mode.
-- `=`    - used to automatically re-indent selected text based on file's indentation settings
-- `<CR>` - enter key
keyset("v", "<A-Up>", ":m '<-2<CR>gv=gv", { silent = true })
keyset("v", "<A-Down>", ":m '>+1<CR>gv=gv", { silent = true })

keyset("i", "<A-Up>", ":m .-2<CR>==gi", {})
keyset("i", "<A-Down>", ":m .+1<CR>==gi", {})

-- terminal escape.
keyset("t", "<Esc>", "<C-\\><C-n>")

keyset("n", "<leader>ca", function()
	vim.lsp.buf.code_action()
end, { desc = "Apply preferred code action" })
keyset("n", "K", function()
	require("pretty_hover").hover()
end, { desc = "Apply preferred code action" })

vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
	group = diagnostics_augroup,
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

vim.api.nvim_create_autocmd("LspProgress", {
	callback = function(ev)
		local is_lsp_index_finished = ev.data and ev.data.params and ev.data.params.value.kind == "end"
		if is_lsp_index_finished then
			local client = vim.lsp.get_client_by_id(ev.data.client_id)
			if not client then
				return
			end
			-- workspace diagnostics
			require("workspace-diagnostics").populate_workspace_diagnostics(client, vim.api.nvim_get_current_buf())
			require("trouble").refresh()
		end
	end,
})

vim.api.nvim_create_autocmd("DiagnosticChanged", {
	callback = function()
		-- Use severity_limit if you only want Errors/Warnings
		vim.diagnostic.setqflist({ open = false })
	end,
})
vim.api.nvim_create_autocmd("User", {
	pattern = "PersistenceSavePre",
	callback = function()
		require("trouble").close()
	end,
})

api.nvim_create_user_command("Format", function()
	require("conform").format({ bufnr = vim.api.nvim_get_current_buf() })
end, {})

vim.cmd([[ colorscheme vague ]])
