local M = {}

M.lua_ls = {
	setup = function(opts, lspconfig)
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

		lspconfig.lua_ls.setup(opts)
	end
}

M.rust_analyzer = {
	setup = function(opts, _)
		local rust_tools = require("rust-tools")
		local termopen = require("rust-tools/executors").termopen
		local rust_tools_dap = require("rust-tools.dap")

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

		rust_tools.setup(opts)
	end
}

M.texlab = {
	setup = function(opts, lspconfig)
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

		lspconfig.texlab.setup(opts)
	end
}

M.pylsp = {
	setup = function(opts, lspconfig)
		opts.settings = {
			pylsp = {
				plugins = {
					pyflakes = { enabled = false },
					jedi_hover = { enabled = false },
				}
			}
		}

		lspconfig.pylsp.setup(opts)
	end
}

M.tsserver = {
	setup = function(opts, lspconfig)
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
		lspconfig.tsserver.setup(opts)
	end
}

return M
