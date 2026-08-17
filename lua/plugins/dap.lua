local function map_dap(suffix, rhs, desc)
	vim.keymap.set("n", "<leader>d" .. suffix, rhs, {
		desc = "Debugger: " .. desc,
		nowait = true,
		remap = false,
	})
end

return { -- config from the article: https://tamerlan.dev/a-guide-to-debugging-applications-in-neovim/
	"mfussenegger/nvim-dap",
	event = "VeryLazy",
	dependencies = {
		"rcarriga/nvim-dap-ui",
		"nvim-neotest/nvim-nio",
		"jay-babu/mason-nvim-dap.nvim",
		"theHamsta/nvim-dap-virtual-text",
	},
	config = function()
		local mason_dap = require("mason-nvim-dap")
		local dap = require("dap")
		local ui = require("dapui")
		local dap_virtual_text = require("nvim-dap-virtual-text")

		dap_virtual_text.setup()

		mason_dap.setup({
			ensure_installed = { "cppdbg" },
			automatic_installation = true,
			handlers = {
				function(config)
					require("mason-nvim-dap").default_setup(config)
				end,
			},
		})

		-- Configurations
		dap.configurations = {
			c = {
				{
					name = "Launch file",
					type = "cppdbg",
					request = "launch",
					program = function()
						return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
					end,
					cwd = "${workspaceFolder}",
					stopAtEntry = false,
					MIMode = "lldb",
				},
				{
					name = "Attach to lldbserver :1234",
					type = "cppdbg",
					request = "launch",
					MIMode = "lldb",
					miDebuggerServerAddress = "localhost:1234",
					miDebuggerPath = "/usr/bin/lldb",
					cwd = "${workspaceFolder}",
					program = function()
						return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
					end,
				},
			},
		}

		-- Dap UI

		ui.setup()

		vim.fn.sign_define("DapBreakpoint", { text = "🐞" })

		dap.listeners.before.attach.dapui_config = function()
			ui.open()
		end
		dap.listeners.before.launch.dapui_config = function()
			ui.open()
		end
		dap.listeners.before.event_terminated.dapui_config = function()
			ui.close()
		end
		dap.listeners.before.event_exited.dapui_config = function()
			ui.close()
		end

		-- key sets
		map_dap("c", function()
			require("dap").continue()
		end, "Start or continue the debugger.")
		map_dap("t", function()
			require("dap").toggle_breakpoint()
		end, "Toggle Breakpoint")
		map_dap("i", function()
			require("dap").step_into()
		end, "Step into")
		map_dap("o", function()
			require("dap").step_over()
		end, "Step over")
		map_dap("u", function()
			require("dap").step_out()
		end, "Step out")
		map_dap("r", function()
			require("dap").repl.open()
		end, "Open REPL")
		map_dap("l", function()
			require("dap").run_last()
		end, "Run last.")
		map_dap("q", function()
			require("dap").terminate()
			require("dapui").close()
			require("nvim-dap-virtual-text").toggle()
		end, "Terminate")
		map_dap("b", function()
			require("dap").list_breakpoints()
		end, "List breakpoints.")
		map_dap("e", function()
			require("dap").set_exception_breakpoints({ "all" })
		end, "Set exception breakpoints.")
	end,
}
