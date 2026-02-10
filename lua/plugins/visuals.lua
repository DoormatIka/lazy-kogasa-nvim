local begin = "\u{1FBE7}"
local ending = "\u{1FBE6}"
local middle = "\u{1CD33}"

return {
	{
		"lewis6991/gitsigns.nvim",
		config = function()
			require("gitsigns").setup({
				signcolumn = false,
				numhl = true,
			})
		end,
	},
	{
		"vague2k/vague.nvim",
		lazy = false,
		priority = 1000,
		opts = {
			transparent = true,
			on_highlights = function(hl, colors)
				local function darken(hex, amount)
					-- convert hex to RGB
					local r = tonumber(hex:sub(2, 3), 16)
					local g = tonumber(hex:sub(4, 5), 16)
					local b = tonumber(hex:sub(6, 7), 16)
					-- darken each channel by amount
					r = math.max(0, r - amount)
					g = math.max(0, g - amount)
					b = math.max(0, b - amount)
					-- return new hex
					return string.format("#%02x%02x%02x", r, g, b)
				end

				hl.DiagnosticLineError = { bg = darken(colors.error, 170) }
				hl.DiagnosticLineWarn = { bg = darken(colors.warning, 170) }
				hl.DiagnosticLineInfo = { bg = darken(colors.hint, 170) }
			end,
		},
	},
	{
		"petertriho/nvim-scrollbar",
		config = function()
			require("scrollbar").setup()
		end,
	},
	{
		"sphamba/smear-cursor.nvim",
		config = function()
			require("smear_cursor").setup({
				cursor_color = "#45d7ff",
				particles_enabled = true,

				stiffness = 0.5,
				trailing_stiffness = 0.5,
				matrix_pixel_threshold = 0.5,

				trailing_exponent = 1,
				damping = 0.6,
				gradient_exponent = 0.5,
				gamma = 1,
				never_draw_over_target = true,
				hide_target_hack = true,
				particle_spread = 1,
				particles_per_second = 500,
				particles_per_length = 50,
				particle_max_lifetime = 800,
				particle_max_initial_velocity = 20,
				particle_velocity_from_cursor = 0.5,
				particle_damping = 0.15,
				particle_gravity = -50,
				min_distance_emit_particles = 1,
				legacy_computing_symbols_support = true,
			})
		end,
	},
	{
		"brenoprata10/nvim-highlight-colors",
		config = function()
			require("nvim-highlight-colors").setup({
				---Render style
				---@usage 'background'|'foreground'|'virtual'
				render = "virtual",

				---Set virtual symbol (requires render to be set to 'virtual')
				virtual_symbol = begin .. middle .. middle .. ending,

				---Set virtual symbol suffix (defaults to '')
				virtual_symbol_prefix = "",

				---Set virtual symbol suffix (defaults to ' ')
				virtual_symbol_suffix = " ",

				---Set virtual symbol position()
				---@usage 'inline'|'eol'|'eow'
				---inline mimics VS Code style
				---eol stands for `end of column` - Recommended to set `virtual_symbol_suffix = ''` when used.
				---eow stands for `end of word` - Recommended to set `virtual_symbol_prefix = ' ' and virtual_symbol_suffix = ''` when used.
				virtual_symbol_position = "inline",

				---Highlight hex colors, e.g. '#FFFFFF'
				enable_hex = true,

				---Highlight short hex colors e.g. '#fff'
				enable_short_hex = true,

				---Highlight rgb colors, e.g. 'rgb(0 0 0)'
				enable_rgb = true,

				---Highlight hsl colors, e.g. 'hsl(150deg 30% 40%)'
				enable_hsl = true,

				---Highlight ansi colors, e.g '\033[0;34m'
				enable_ansi = true,

				-- Highlight hsl colors without function, e.g. '--foreground: 0 69% 69%;'
				enable_hsl_without_function = true,

				---Highlight CSS variables, e.g. 'var(--testing-color)'
				enable_var_usage = true,

				---Highlight named colors, e.g. 'green'
				enable_named_colors = true,

				---Highlight tailwind colors, e.g. 'bg-blue-500'
				enable_tailwind = true,

				---Set custom colors
				---Label must be properly escaped with '%' to adhere to `string.gmatch`
				--- :help string.gmatch
				custom_colors = {
					{ label = "%-%-theme%-primary%-color", color = "#0f1219" },
					{ label = "%-%-theme%-secondary%-color", color = "#5a5d64" },
				},

				-- Exclude filetypes or buftypes from highlighting e.g. 'exclude_buftypes = {'text'}'
				exclude_filetypes = {},
				exclude_buftypes = {},
				-- Exclude buffer from highlighting e.g. 'exclude_buffer = function(bufnr) return vim.fn.getfsize(vim.api.nvim_buf_get_name(bufnr)) > 1000000 end'
				exclude_buffer = function(_) end,
			})
		end,
	},
}
