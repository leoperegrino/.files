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
				maxMemoryMB = 4096,
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

M.pyright = {
	-- cmd = { "nix", "shell", "nixpkgs#pyright", "--command", "pyright-langserver", "--stdio" },
}

M.ruff = {
	-- cmd = { "nix", "run", "nixpkgs#ruff", '--', 'server', },
	init_options = {
		settings = {
			isort = {
				['force-single-line'] = true,
			},
			lint = {
				isort = {
					['force-single-line'] = true,
				},
				select = { "F", "I" },
				['extended-select'] = { "F", "I" },
			},
		},
	},
}

M.denols = {
	-- cmd = { "nix", "run", "nixpkgs#deno", "lsp" },
}

M.metals = {
	-- cmd = { 'nix', 'run', 'nixpkgs#metals' },
}

M.terraformls = {
	-- cmd = { 'nix', 'run', 'nixpkgs#terraform-ls', '--', 'serve' },
}

M.sqls = {
	-- cmd = { 'nix', 'run', 'nixpkgs#sqls', '--',  '-config', '~/.config/sqls/config.yml' },
}

M.gopls = {
	-- cmd = { 'nix', 'run', 'nixpkgs#gopls', '--', 'serve' },
	settings = {
		gopls = {
			hints = {
				assignVariableTypes = false,
				compositeLiteralFields = false,
				compositeLiteralTypes = false,
				constantValues = false,
				functionTypeParameters = false,
				parameterNames = false,
				rangeVariableTypes = false,
			},
		},
	},
}

M.docker_compose_language_service = {
	-- cmd = { 'nix', 'run', 'nixpkgs#docker-compose-langserver', '--', '--stdio' }
}

M.dockerls = {
	-- cmd = { 'nix', 'run', 'nixpkgs#dockerfile-language-server-nodejs', '--', '--stdio' },
}

M.bashls = {
	-- cmd = { 'nix', 'run', 'nixpkgs#bash-language-server', '--', 'start' },
}

M.jsonls = {
	-- cmd = { 'nix', 'run', 'nixpkgs#nodePackages.vscode-json-languageserver', '--', '--stdio' },
}

return M
