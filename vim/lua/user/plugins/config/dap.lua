local dap = require("dap")
local dapui = require("dapui")
local dap_vt = require("nvim-dap-virtual-text")
local dap_python = require("dap-python")

vim.fn.sign_define("DapBreakpoint", { text = "🌕"})
vim.fn.sign_define("DapStopped", { text = "🌑"})

dap_python.test_runner = "pytest"

dap.listeners.after.event_initialized["dapui_config"] = function()
	dapui.open()
end
-- dap.listeners.before.event_terminated["dapui_config"] = function()
-- 	dapui.close()
-- end
dap.listeners.before.event_exited["dapui_config"] = function()
	dapui.close()
end

dap_python.setup("python", {
	console = "externalTerminal",
	include_configs = true,
})

dap_vt.setup {
	enabled = true,
	enabled_commands = true,
	highlight_changed_variables = true,
	highlight_new_as_changed = false,
	show_stop_reason = true,
	commented = false,                     -- prefix virtual text with comment string
	only_first_definition = true,
	all_references = false,
	filter_references_pattern = '<module', -- filter references (not definitions) pattern when all_references is activated (Lua gmatch pattern, default filters out Python modules)
		-- experimental features:
		virt_text_pos = 'eol',                 -- position of virtual text, see `:h nvim_buf_set_extmark()`
	all_frames = false,                    -- show virtual text for all stack frames not only current. Only works for debugpy on my machine.
	virt_lines = false,                    -- show virtual lines instead of virtual text (will flicker!)
	virt_text_win_col = 80,
}

dapui.setup({
	icons = { expanded = "▾", collapsed = "▸" },
	mappings = {
		expand = { "<CR>", "<2-LeftMouse>" },
		open = "o",
		remove = "d",
		edit = "e",
		repl = "r",
		toggle = "t",
	},
	expand_lines = vim.fn.has("nvim-0.7"),
	layouts = {
		{
			elements = {
				'scopes',
				'breakpoints',
				'stacks',
				'watches',
			},
			size = 40,
			position = 'left',
		},
		{
			elements = {
				'repl',
				'console',
			},
			size = 10,
			position = 'bottom',
		},
	},
	floating = {
		max_height = nil, -- These can be integers or a float between 0 and 1.
		max_width = nil, -- Floats will be treated as percentage of your screen.
		border = "single", -- Border style. Can be "single", "double" or "rounded"
		mappings = {
			close = { "q", "<Esc>" },
		},
	},
	windows = { indent = 1 },
	render = {
		max_type_length = nil, -- Can be integer or nil.
	}
})
