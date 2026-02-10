---@type table<string, vim.lsp.Config>
local M = {}

--- Checks if the default command is executable else uses a fallback
--- @param name string The LSP config name to use for the default cmd
--- @param fallback string[] fallback command
--- @return string[]? R the command array if available
local function cmd_or_fallback(name, fallback)

	local lsp_config = vim.lsp.config[name]

	if not lsp_config or not lsp_config.cmd then
		vim.notify(string.format(
			"Invalid vim.lsp.config name: %s",
			name
		), vim.log.levels.ERROR)
		return
	end

	local default_cmd = lsp_config.cmd

	if type(default_cmd) == 'function' then
		vim.notify(string.format(
			"the default cmd is a lua function and \z
			it's not going to be overrided."
		), vim.log.levels.WARN)
		return
	end

	if type(default_cmd) == 'table' and vim.fn.executable(default_cmd[1]) == 1 then
		return default_cmd
	end

	return fallback
end

--- Helper to add LSP config with automatic name passing
--- @param name string
--- @param config vim.lsp.Config
--- @param fallback string[]
local function add_lsp(name, config, fallback)

	local cmd = cmd_or_fallback(name, fallback)
	if cmd ~= nil then
		config.cmd = cmd
	end

	M[name] = config
end


add_lsp(
	'nil_ls',
	{
		-- https://github.com/oxalica/nil/blob/main/docs/configuration.md
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
	},
	{ "nix", "run", "nixpkgs#nil" }
)

add_lsp(
	'nixd',
	{},
	{ "nix", "run", "nixpkgs#nixd" }
)

add_lsp(
	'lua_ls',
	{
		settings = {
			Lua = {
				telemetry = {
					enable = false,
				},
			}
		}
	},
	{ "nix", "run", "nixpkgs#lua-language-server" }
)

add_lsp(
	'texlab',
	{},
	{ "nix", "run", "nixpkgs#texlab" }
)


add_lsp(
	'pyright',
	{},
	{ "nix", "shell", "nixpkgs#pyright", "--command", "pyright-langserver", "--stdio" }
)

add_lsp(
	'ruff',
	{
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
	},
	{ "nix", "run", "nixpkgs#ruff", '--', 'server' }
)

add_lsp(
	'denols',
	{},
	{ "nix", "run", "nixpkgs#deno", '--', 'lsp', }
)

add_lsp(
	'metals',
	{},
	{ "nix", "run", "nixpkgs#metals" }
)

add_lsp(
	'terraformls',
	{},
	{ "nix", "run", "nixpkgs#terraform-ls", '--', 'serve' }
)

add_lsp(
	'sqls',
	{},
	{ "nix", "run", "nixpkgs#sqls", '--', '-config', '~/.config/sqls/config.yml' }
)

add_lsp(
	'gopls',
	{
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
	},
	{ 'nix', 'run', 'nixpkgs#gopls', '--', 'serve' }
)

add_lsp(
	'docker_compose_language_service',
	{},
	{ "nix", "run", "nixpkgs#docker-compose-langserver", '--', '--stdio' }
)

add_lsp(
	'dockerls',
	{},
	{ "nix", "run", "nixpkgs#dockerfile-language-server-nodejs", '--', '--stdio' }
)

add_lsp(
	'bashls',
	{},
	{ "nix", "run", "nixpkgs#bash-language-server", '--', 'start' }
)

add_lsp(
	'jsonls',
	{},
	{ "nix", "run", "nixpkgs#nodePackages.vscode-json-languageserver", '--', '--stdio' }
)

return M
