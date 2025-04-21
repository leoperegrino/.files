local function keymap(mode, lhs, rhs, desc)
	vim.keymap.set(mode, lhs, rhs, {
		desc = 'dap: ' .. desc,
		noremap = true,
		silent = true,
	})
end


-- TODO: configure this according to lazy spec (keys, opts, buffers, config, etc)
return {

	{ 'mfussenegger/nvim-dap',
		config = function(_, _)
			local dap = require("dap")
			local telescope = require('telescope.builtin')

			vim.fn.sign_define("DapBreakpoint", { text = "🌕"})
			vim.fn.sign_define("DapStopped", { text = "🌑"})

			keymap('n', '<leader>dk',
				function() telescope.keymaps({ default_text = 'dap: ' }) end,
				"keymaps"
			)
			keymap('n', '<leader>dK',
				function() telescope.commands({ default_text = 'Dap' }) end,
				"commands"
			)

			keymap('n', '<leader>dc', dap.continue , "continue")

			-- keymap('n', '<leader>dC', dap.run, "run")

			keymap('n', '<F5>', dap.step_into        , "step into")
			keymap('n', '<F6>', dap.step_out         , "step out")
			keymap('n', '<F7>', dap.step_over        , "step over")
			keymap('n', '<F8>', dap.toggle_breakpoint, "toggle breakpoint")
			keymap('n', '<F9>', dap.continue         , "continue")

			keymap('n', '<leader>do', dap.step_over, "step over")
			keymap('n', '<leader>di', dap.step_into, "step into")
			keymap('n', '<leader>dO', dap.step_out , "step out")
			keymap('n', '<leader>dU', dap.up       , "go up in the stack")
			keymap('n', '<leader>dD', dap.down     , "go down in the stack")

			keymap('n', '<leader>dR', dap.restart  , "restart session")
			keymap('n', '<leader>dt', dap.terminate, "terminate session")
			keymap('n', '<leader>dP', dap.pause    , "pause a thread")

			keymap('n', '<leader>dr', dap.repl.toggle, "toggle repl")

			keymap('n', '<leader>dbb', dap.toggle_breakpoint, "toggle breakpoint")
			-- keymap('n', '<leader>dbl', dap.list_breakpoints , "list breakpoints")
			keymap('n', '<leader>dbc', dap.clear_breakpoints , "clear breakpoints")

			keymap('n', '<leader>dbB',
				function() dap.set_breakpoint(nil, nil, vim.fn.input('message: ')) end,
				"add breakpoint with comment"
			)
		end
	},

	{ 'mfussenegger/nvim-dap-python',
		dependencies = { { 'mfussenegger/nvim-dap' }, },
		config = function(_, _)
			local dap_python = require("dap-python")

			keymap('n', '<leader>dpm', dap_python.test_method, "python: test method")
			keymap('n', '<leader>dpc', dap_python.test_class, "python: test class")

			dap_python.test_runner = "pytest"
			dap_python.setup("python")
		end,
	},

	{ 'theHamsta/nvim-dap-virtual-text',
		dependencies = { { 'mfussenegger/nvim-dap' }, },
		opts = {},
	},

	{ "rcarriga/nvim-dap-ui",
		dependencies = { { "mfussenegger/nvim-dap" }, { "nvim-neotest/nvim-nio" }, },
		config = function()
			local dap = require("dap")
			local dapui = require("dapui")

			keymap("n"       , "<leader>dd", dapui.toggle, "dapui: toggle ui")
			keymap({"n", "v"}, "<leader>de", dapui.eval  , "dapui: eval expression")

			keymap("n", "<leader>df",
				function() dapui.float_element("scopes") end,
				"dapui: open floating scopes"
			)

			dapui.setup({
				-- breakpoints, stacks, watches, scopes, repl, console
				layouts = {
					{
						elements = { { id = "scopes", size = 1 }, },
						position = "left",
						size = 30
					},
					-- {
					-- 	elements = { { id = "repl", size = 1 }, },
					-- 	position = "bottom",
					-- 	size = 10
					-- },
					{
						elements = { { id = "console", size = 1 } },
						position = "bottom",
						size = 2
					},
				}
			})

			dap.listeners.before.attach.dapui_config = function()
				dapui.open()
			end
			dap.listeners.before.launch.dapui_config = function()
				dapui.open()
			end
			dap.listeners.before.event_terminated.dapui_config = function()
				-- dapui.close()
			end
			dap.listeners.before.event_exited.dapui_config = function()
				-- dapui.close()
			end
		end,
	},
}
