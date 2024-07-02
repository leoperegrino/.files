local M = {}

M.lua_ls = {
	settings = {
		Lua = {
			telemetry = {
				enable = false,
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

-- pip install "python-lsp-server[all]
M.pylsp = {
	-- cmd = { 'python',  '-m', 'pylsp' },
	settings = {
		pylsp = {
			plugins = {
				jedi_hover = { enabled = true },

				-- optional providers

				-- for code formatting, prefer yapf
				autopep8 = { enabled = false },

				-- for error checking (disabled by default)
				flake8 = { enabled = false },

				-- linter for complexity checking
				mccabe = { enabled = true },

				-- linter for style checking
				pycodestyle = { enabled = true },

				-- linter for docstring style checking (disabled by default)
				pydocstyle = { enabled = false, convention = 'pep257', addIgnore = { 'D100' } },

				-- linter to detect various errors
				pyflakes = { enabled = false },

				-- for code linting (disabled by default)
				pylint = { enabled = true, args = { '--disable=C0114,C0115,C0116'} },

				-- for Completions and renaming
				rope = { enabled = true },

				-- for code formatting (preferred over autopep8)
				yapf = { enabled = true },
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
