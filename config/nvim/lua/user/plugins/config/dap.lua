local M = {}

local keymap_with = require('user.utils').keymap_with

local keymap = keymap_with({
	noremap = true,
	silent = true
})


M.dap = function()
	local dap = require("dap")
	local telescope = require('telescope.builtin')

	vim.fn.sign_define("DapBreakpoint", { text = "🌕"})
	vim.fn.sign_define("DapStopped", { text = "🌑"})

	keymap('n', '<leader>dk',
		function() telescope.keymaps({ default_text = 'dap: ' }) end,
		"dap: keymaps"
	)
	keymap('n', '<leader>dK',
		function() telescope.commands({ default_text = 'Dap' }) end,
		"Dap: commands"
	)

	keymap('n', '<leader>dc', dap.continue , "dap: continue")

	-- keymap('n', '<leader>dC', dap.run, "dap: run")

	keymap('n', '<F5>', dap.step_into        , "dap: step into")
	keymap('n', '<F6>', dap.step_out         , "dap: step out")
	keymap('n', '<F7>', dap.step_over        , "dap: step over")
	keymap('n', '<F8>', dap.toggle_breakpoint, "dap: toggle breakpoint")
	keymap('n', '<F9>', dap.continue         , "dap: continue")

	keymap('n', '<leader>do', dap.step_over, "dap: step over")
	keymap('n', '<leader>di', dap.step_into, "dap: step into")
	keymap('n', '<leader>dO', dap.step_out , "dap: step out")
	keymap('n', '<leader>dU', dap.up       , "dap: go up in the stack")
	keymap('n', '<leader>dD', dap.down     , "dap: go down in the stack")

	keymap('n', '<leader>dR', dap.restart  , "dap: restart session")
	keymap('n', '<leader>dt', dap.terminate, "dap: terminate session")
	keymap('n', '<leader>dP', dap.pause    , "dap: pause a thread")

	keymap('n', '<leader>dr', dap.repl.toggle, "dap: toggle repl")

	keymap('n', '<leader>dbb', dap.toggle_breakpoint, "dap: toggle breakpoint")
	-- keymap('n', '<leader>dbl', dap.list_breakpoints , "dap: list breakpoints")
	keymap('n', '<leader>dbc', dap.clear_breakpoints , "dap: clear breakpoints")

	keymap('n', '<leader>dbB',
		function() dap.set_breakpoint(nil, nil, vim.fn.input('message: ')) end,
		"dap: add breakpoint with comment"
	)
end


M.dap_python = function()
	local dap_python = require("dap-python")

	keymap('n', '<leader>dpm', dap_python.test_method, "dap-python: test method")
	keymap('n', '<leader>dpc', dap_python.test_class, "dap-python: test class")

	dap_python.test_runner = "pytest"
	dap_python.setup("python")
end


M.dapui = function()
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
end


M.dap_vt = function()
	local dap_vt = require("nvim-dap-virtual-text")

	dap_vt.setup()
end


return M
