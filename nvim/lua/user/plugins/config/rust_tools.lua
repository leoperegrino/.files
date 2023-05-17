local M = {}

local rust_tools = require("rust-tools")
local termopen = require("rust-tools/executors").termopen
local rust_tools_dap = require("rust-tools.dap")


M.setup = function(opts)

	opts.tools = {
		autoSetHints = true,
		executor = termopen,
		on_initialized = nil,
		inlay_hints = {
			only_current_line = false,
			only_current_line_autocmd = "CursorHold",
			show_parameter_hints = true,
			show_variable_name = false,
			parameter_hints_prefix = "<- ",
			other_hints_prefix = "=> ",
			max_len_align = true,
			max_len_align_padding = 5,
			right_align = false,
			right_align_padding = 7,
			highlight = "Comment",
		},
		hover_actions = { auto_focus = false },
	}

	opts.dap = {
		adapter = rust_tools_dap.get_codelldb_adapter(
			"/usr/bin/codelldb",
			"/usr/lib/codelldb/lldb/lib/liblldb.so"
		)
	}

	opts.server = {
		settings = {
			["rust-analyzer"] = {
				inlayHints = { locationLinks = false },
			}
		}
	}

	local default_attach = opts.on_attach
	opts.on_attach = nil

	opts.server.on_attach = function(client, bufnr)
		default_attach(client, bufnr)

		vim.keymap.set("n", "K",
			":RustHoverActions<CR>" ,
			{ buffer = bufnr, noremap = true, silent = true }
		)
	end

	rust_tools.setup(opts)
end


return M
