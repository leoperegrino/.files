---@type table<string, vim.lsp.Config>
local M = {}

--- Nix shell configuration
--- @class NixShell
--- @field shell string Package name for 'nix shell nixpkgs#package --command ...'
--- @field command string Command name to use with nix shell
--- @field args? string[] Additional arguments

--- Nix run configuration
--- @class NixRun
--- @field run string Package name for 'nix run nixpkgs#package'
--- @field args? string[] Additional arguments

--- Nix fallback options (either shell or run)
--- @alias NixOptions NixShell|NixRun
--- LSP command type (copied from vim.lsp.Config.cmd)
--- @alias LspCmd (fun(dispatchers: vim.lsp.rpc.Dispatchers, config: vim.lsp.ClientConfig):vim.lsp.rpc.PublicClient|string[])?

--- Checks if a command is executable, falls back to nix ephemeral run
--- @param name string The LSP config name to use for the default cmd
--- @param nix NixOptions nix cmd options
--- @return LspCmd R the command array if available
local function cmd_or_nix(name, nix)

	local lsp_config = vim.lsp.config[name]

	if not lsp_config or not lsp_config.cmd then
		vim.notify(string.format(
			"Invalid vim.lsp.config name: %s",
			name
		), vim.log.levels.ERROR)
		return
	end

	local default_cmd = lsp_config.cmd

	return function(dispatchers, config)

		if type(default_cmd) == 'function' then
			vim.notify(string.format(
				"the default cmd is a lua function and \z
				it's not going to be overrided."
			), vim.log.levels.WARN)
			return default_cmd(dispatchers, config)

		elseif type(default_cmd) == 'table' then
			if vim.fn.executable(default_cmd[1]) == 1 then
				return vim.lsp.rpc.start(default_cmd, dispatchers)
			else
				vim.notify(string.format(
					"%s is not executable, falling back to nix run. \z
					this may take some time if not cached.",
					default_cmd[1]
				), vim.log.levels.WARN)
			end
		end

		---@type string[]
		local cmd

		if nix.shell then
			cmd = {
				'nix',
				'shell',
				'nixpkgs#' .. nix.shell,
				'--command',
				nix.command,
			}
		elseif nix.run then
			cmd = {
				'nix',
				'run',
				'nixpkgs#' .. nix.run,
			}
		else
			vim.notify(string.format(
				"NixOptions must have either 'shell' or 'run' field for %s",
				name
			), vim.log.levels.ERROR)
			error()
		end

		if nix.args then
			vim.list_extend(cmd, nix.args)
		end

		return vim.lsp.rpc.start(cmd, dispatchers)
	end
end

--- LSP config with nix options
--- @class LspConfigWithNix: vim.lsp.ClientConfig
--- @field nix NixOptions
--- @field cmd nil

--- Helper to add LSP config with automatic name passing
--- @param name string
--- @param config_with_nix LspConfigWithNix
local function add_lsp(name, config_with_nix)

	local nix_opts = config_with_nix.nix
	config_with_nix.nix = nil

	---@type vim.lsp.Config
	local config = vim.tbl_extend('force', config_with_nix, {
		cmd = cmd_or_nix(name, nix_opts),
	})

	M[name] = config
end


add_lsp('nil_ls',{
	-- https://github.com/oxalica/nil/blob/main/docs/configuration.md
	nix = { run = "nil" },
	settings = {
		["nil"] = {
			formatting = {
				command = { "nixfmt-rfc-style" },
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
})

add_lsp('nixd', {
	nix = { run = "nixd" },
})

add_lsp('lua_ls', {
	nix = { run = "lua-language-server" },
	settings = {
		Lua = {
			workspace = {
				checkThirdParty = false,
				library = {
					vim.env.VIMRUNTIME
					-- https://github.com/neovim/nvim-lspconfig/issues/3189
					-- vim.api.nvim_get_runtime_file('', true)
				},
			},
			telemetry = {
				enable = false,
			},
			completion = {
				callSnipet = "Replace",
			},
			hint = {
				enable = true,
				setType = false,
				paramType = false,
				paramName = "Disable",
				semicolon = "Disable",
				arrayIndex = "Disable",
			},
			diagnostics = {
				-- globals = { "vim", "require" },
				unusedLocalExclude = {
					'_*'
				},
			},
			codeLens = {
				enable = true,
			},
			doc = {
				privateName = { "^_" },
			},
		}
	}
})

add_lsp('texlab', {
	nix = { run = "texlab" },
})


add_lsp('pyright', {
	nix = {
		shell = "pyright",
		command = 'pyright-langserver',
		args = { '--stdio' },
	},
})

add_lsp('ruff', {
	nix = {
		run = "ruff",
		args = { 'server' },
	},
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
})

add_lsp('denols', {
	nix = {
		run = 'deno',
		args = { 'lsp' },
	},
})

add_lsp('metals', {
	nix = {
		run = 'metals',
	},
})

add_lsp('terraformls', {
	nix = {
		run = 'terraform-ls',
		args = { 'serve' },
	},
})

add_lsp('sqls', {
	nix = {
		run = 'sqls',
		args = { '-config', '~/.config/sqls/config.yml' },
	},
})

add_lsp('gopls', {
	nix = {
		run = 'gopls',
		args = { 'serve' },
	},
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
})

add_lsp('docker_compose_language_service', {
	nix = {
		run = 'docker-compose-langserver',
		args = { '--stdio' },
	},
})

add_lsp('dockerls', {
	nix = {
		run = 'dockerfile-language-server-nodejs',
		args = { '--stdio' },
	},
})

add_lsp('bashls', {
	nix = {
		run = 'bash-language-server',
		args = { 'start' },
	},
})

add_lsp('jsonls', {
	nix = {
		run = 'nodePackages.vscode-json-languageserver',
		args = { '--stdio' },
	},
})

return M
