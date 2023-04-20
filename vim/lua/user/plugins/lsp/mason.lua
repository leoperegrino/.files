local M = {}

local utils = require('user.utils')

local lspconfig = require("lspconfig")
local mason = require("mason")
local mason_lspconfig = require("mason-lspconfig")


M.setup_servers = function(config, opts)
	local servers = mason_lspconfig.get_installed_servers()

	for _, server in ipairs(servers) do
		if server == 'rust_analyzer' then
		else

			opts = utils.merge(opts, config[server])

			lspconfig[server].setup(opts)
		end
	end
end


M.autocmd = function()
	vim.api.nvim_create_autocmd("FileType", {
		pattern = {"mason", "lsp-installer", "lspinfo"},
		callback = function()
			vim.api.nvim_win_set_config(0, { border = "rounded" })
		end,
	})
end


M.attach = function(config, opts)
	mason.setup()
	mason_lspconfig.setup()

	M.setup_servers(config, opts)

	M.autocmd()
end

return M
