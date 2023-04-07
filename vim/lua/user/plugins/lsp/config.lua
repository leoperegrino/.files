local M = {}

M.lua_ls = {
	settings = {
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
}

M.texlab = {
	settings = {
		texlab = {
			build = {
				args = { "-v", "%f" },
				executable = "arara",
				forwardSearchAfter = true,
				onSave = true
			}
		}
	}
}

M.pylsp = {
	settings = {
		pylsp = {
			plugins = {
				pyflakes = { enabled = false },
				jedi_hover = { enabled = false },
			}
		}
	}
}

M.tsserver = {
	-- opts.filetypes = { "typescript", "typescriptreact", "typescript.tsx" }
	init_options = { preferences = { disableSuggestions = true }},
	settings = {
		tsserver = {
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
}

return M
