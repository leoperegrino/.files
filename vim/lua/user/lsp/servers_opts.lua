local servers_opts = {}

servers_opts.sumneko_lua = function(server, opts)
	opts.settings = {
		Lua = {
			diagnostics = { globals = { "vim" }, },
			workspace = {
				library = {
					[vim.fn.expand("$VIMRUNTIME/lua")] = true,
					[vim.fn.stdpath("config") .. "/lua"] = true,
				},
			},
		},
	}

	server:setup(opts)
end

servers_opts.rust_analyzer = function(server, opts)
	local rust_tools_ok, rust_tools = pcall(require, "rust-tools")
	if not rust_tools_ok then
		return
	end

	local tools = {
		autoSetHints = true,
		hover_with_actions = true,
		executor = require("rust-tools/executors").termopen,
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

	local dap = {
		adapter = {
			type = "executable",
			command = "lldb-vscode",
			name = "rt_lldb",
		},
	}

	local rust_opts = vim.tbl_deep_extend("force", server:get_default_options(), opts)
	rust_tools.setup { server = rust_opts , tools = tools, dap = dap}
	server:attach_buffers()
	rust_tools.start_standalone_if_required()
end

servers_opts.pylsp = function(server, opts)
	opts.settings = {
		pylsp = {
			plugins = {
				jedi_hover = {
					enabled = false
				}
			}
		}
	}

	server:setup(opts)
end

return servers_opts
