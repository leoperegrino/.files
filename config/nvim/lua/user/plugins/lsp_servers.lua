local M = {}

M.nil_ls = {
	-- https://github.com/oxalica/nil/blob/main/docs/configuration.md
	-- cmd = { "nix", "run", "nixpkgs#nil" },
	settings = {
		["nil"] = {
			formatting = {
				command = { "nix", "run", "nixpkgs#nixfmt-rfc-style" },
			},
			nix = {
				-- maxMemoryMB = 2048,
				flake = {
					-- calls `nix flake archive` to put a flake and its output to store
					autoArchive = false,
					-- auto eval flake inputs for improved completion
					autoEvalInputs = false,
					-- The input name of nixpkgs for NixOS options evaluation.
					nixpkgsInputName = "nixpkgs",
				},
			},
		},
	},
}

M.lua_ls = {
	-- cmd = { "nix", "run", "nixpkgs#lua-language-server" },
	settings = {
		Lua = {
			diagnostics = { globals = { "vim", "require" }, },
			telemetry = {
				enable = false,
			},
		},
	}
}

M.texlab = {
	-- cmd = { "nix", "run", "nixpkgs#texlab" },
}

-- pip install "python-lsp-server[all]"
M.pylsp = {
	-- cmd = { 'python',  '-m', 'pylsp' },
	-- cmd = { "nix", "run", "nixpkgs#python3Packages.python-lsp-server" },
	-- cmd = {
	-- 	"nix-shell",
	-- 	"--impure",
	-- 	"--expr", "let pkgs = import <nixpkgs> {}; in pkgs.mkShell { packages = [ (pkgs.python3.withPackages (pp: with pp; [ python-lsp-server ] ++ python-lsp-server.optional-dependencies.all)) ]; }",
	-- 	"--run", "pylsp"
	-- },
	settings = {
		pylsp = {
			plugins = {
				jedi_hover = { enabled = false },

				-- optional providers

				-- for code formatting, prefer yapf
				autopep8 = { enabled = false },

				-- for error checking (disabled by default)
				flake8 = { enabled = false },

				-- linter for complexity checking
				mccabe = { enabled = true },

				-- linter for style checking
				pycodestyle = { enabled = false },

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

M.pyright = {
	-- cmd = { "nix", "shell", "nixpkgs#pyright", "--command", "pyright-langserver", "--stdio" },
}

M.ruff = {
	-- cmd = { "nix", "run", "nixpkgs#ruff", '--', 'server', },
}

M.denols = {
	-- cmd = { "nix", "run", "nixpkgs#deno", "lsp" },
}

M.metals = {
	-- cmd = { 'nix', 'run', 'nixpkgs#metals' },
}

M.terraformls = {
	-- cmd = { 'nix', 'run', 'nixpkgs#terraform-ls', '--', 'serve' },
	filetypes = { "terraform", "terraform-vars" },
}

M.sqls = {
	-- cmd = { 'nix', 'run', 'nixpkgs#sqls', '--',  '-config', '~/.config/sqls/config.yml' },
}

M.gopls = {
	-- cmd = { 'nix', 'run', 'nixpkgs#gopls', '--', 'serve' },
}

M.docker_compose_language_service = {
	-- cmd = { 'nix', 'run', 'nixpkgs#docker-compose-langserver', '--', '--stdio' }
}

M.dockerls = {
	-- cmd = { 'nix', 'run', 'nixpkgs#dockerfile-language-server-nodejs', '--', '--stdio' },
}

return M
