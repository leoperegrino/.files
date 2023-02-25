local servers_opts = {}

local lspconfig = require("lspconfig")

servers_opts.lua_ls = function(server, opts)
	opts.settings = {
		Lua = {
			diagnostics = { globals = { "vim", "require" }, },
			workspace = {
				library = {
					[vim.fn.expand("$VIMRUNTIME/lua")] = true,
					[vim.fn.stdpath("config") .. "/lua"] = true,
				},
			},
		},
	}

	lspconfig[server].setup(opts)
end

servers_opts.rust_analyzer = function(_, opts)
	local rust_tools_ok, rust_tools = pcall(require, "rust-tools")
	if not rust_tools_ok then
		return
	end

	opts.tools = {
		autoSetHints = true,
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

	opts.dap = {
		adapter = require("rust-tools.dap").get_codelldb_adapter(
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

	rust_tools.setup(opts)
end

servers_opts.texlab = function(server, opts)
	opts.settings = {
		texlab = {
			build = {
				args = { "-v", "%f" },
				executable = "arara",
				forwardSearchAfter = true,
				onSave = true
			}
		}
	}

	lspconfig[server].setup(opts)
end

servers_opts.pylsp = function(server, opts)
	opts.settings = {
		pylsp = {
			plugins = {
				pyflakes = { enabled = false },
				jedi_hover = { enabled = false },
			}
		}
	}

	lspconfig[server].setup(opts)
end

servers_opts.tsserver = function(server, opts)
	-- opts.filetypes = { "typescript", "typescriptreact", "typescript.tsx" }
	opts.init_options = { preferences = { disableSuggestions = true }}
	opts.settings = {
		tsserver =
			{
				compilerOptions = {
					module = "commonjs",
					target = "es6",
					checkJs = false
				},
				exclude = {
					"node_modules"
				}
		}
	}
	lspconfig[server].setup(opts)
end

return servers_opts
