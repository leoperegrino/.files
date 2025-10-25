return {

	{ 'mfussenegger/nvim-dap',
		dependencies = {
			's1n7ax/nvim-window-picker',
		},
		config = function()
			local dap = require('dap')
			dap.defaults.fallback.terminal_win_cmd = require('window-picker').pick_window
			vim.fn.sign_define("DapBreakpoint", { text = "🔵" })
			vim.fn.sign_define("DapBreakpointCondition", { text = "🟡" })
			vim.fn.sign_define("DapLogPoint", { text = "📝" })
			vim.fn.sign_define("DapStopped", { text = "🔴" })
			vim.fn.sign_define("DapBreakpointRejected", { text = "❌" })
		end,
		keys = {
			{ '<leader>dc' , function() require("dap").continue() end, desc = 'dap: continue' },
			{ '<F9>'       , function() require("dap").continue() end, desc = 'dap: continue' },
			{ '<leader>do' , function() require("dap").step_over() end, desc = 'dap: step over' },
			{ '<F8>'       , function() require("dap").step_over() end, desc = 'dap: step over' },
			{ '<leader>dn' , function() require("dap").step_over() end, desc = 'dap: step over' },
			{ '<leader>di' , function() require("dap").step_into() end, desc = 'dap: step into' },
			{ '<F5>'       , function() require("dap").step_into() end, desc = 'dap: step into' },
			{ '<leader>dO' , function() require("dap").step_out() end, desc = 'dap: step out' },
			{ '<F6>'       , function() require("dap").step_out() end, desc = 'dap: step out' },
			{ '<leader>dU' , function() require("dap").up() end, desc = 'dap: go up in the stack' },
			{ '<leader>dD' , function() require("dap").down() end, desc = 'dap: go down in the stack' },
			{ '<leader>dR' , function() require("dap").restart() end, desc = 'dap: restart session' },
			{ '<leader>dt' , function() require("dap").terminate() end, desc = 'dap: terminate session' },
			{ '<leader>dP' , function() require("dap").pause() end, desc = 'dap: pause a thread' },
			{ '<leader>dr' , function() require("dap").repl.toggle() end, desc = 'dap: toggle repl' },
			{ '<leader>dbb', function() require("dap").toggle_breakpoint() end, desc = 'dap: toggle breakpoint' },
			{ '<F7>'       , function() require("dap").toggle_breakpoint() end, desc = 'dap: toggle breakpoint' },
			{ '<leader>dbc', function() require("dap").clear_breakpoints() end, desc = 'dap: clear breakpoints' },
		}
	},

	{ 'mfussenegger/nvim-dap-python',
		dependencies = { { 'mfussenegger/nvim-dap' }, },
		build = false,
		config = function()
			local dap_python = require("dap-python")

			dap_python.test_runner = "pytest"
			dap_python.setup("python")
		end,
		keys = {
			{ '<leader>dpm', function() require("dap-python").test_method() end, desc = "dap-python: test method"},
			{ '<leader>dpc', function() require("dap-python").test_class() end, desc = "dap-python: test class"},

		},
	},

	{ 'theHamsta/nvim-dap-virtual-text',
		dependencies = { { 'mfussenegger/nvim-dap' }, },
		opts = {},
	},

	{ "rcarriga/nvim-dap-ui",
		dependencies = {
			"mfussenegger/nvim-dap",
			"nvim-neotest/nvim-nio",
			's1n7ax/nvim-window-picker',
		},
		opts = {
			select_window = function() return require('window-picker').pick_window() end,
			-- layouts = {
				-- { elements = { { id = "scopes", size = 1 }, }, position = "left", size = 30 },
				-- { elements = { { id = "repl", size = 1 }, }, position = "bottom", size = 10 },
				-- { elements = { { id = "console", size = 1 } }, position = "bottom", size = 2 },
			-- },
		},
		keys = {
			{ '<leader>dd', function() require("dapui").toggle() end, desc = 'dapui: toggle ui' },
			{ '<leader>de', function() require("dapui").eval() end, desc = 'dapui: eval expression', mode = {'n', 'v'} },
			{ '<leader>df', function() require("dapui").float_element('scopes') end, desc = 'dapui: open floating scopes' },
		},
		config = function(_, opts)
			local dap = require("dap")
			local before = dap.listeners.before
			local dapui = require("dapui")

			dapui.setup(opts)

			before.attach.dapui_config = function() dapui.open() end
			before.launch.dapui_config = function() dapui.open() end
			-- before.event_terminated.dapui_config = function() dapui.close() end
			-- before.event_exited.dapui_config = function() dapui.close() end
		end,
	},

	{ 'leoluz/nvim-dap-go',
		opts = {
		},
		ft = 'go',
	},
}
