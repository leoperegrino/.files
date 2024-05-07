local M = {}

local deep_extend = vim.tbl_deep_extend

local lspconfig = require("lspconfig")
local mason = require("mason")
local mason_lspconfig = require("mason-lspconfig")


local autocmd = function()
	vim.api.nvim_create_autocmd("FileType", {
		pattern = {"mason", "lsp-installer", "lspinfo"},
		callback = function()
			vim.api.nvim_win_set_config(0, { border = "rounded" })
		end,
	})
end


M.setup = function(config, opts)
	autocmd()
	mason.setup()
	mason_lspconfig.setup()

	-- skip `rust_analyzer` because of `rust_tools`
	local servers = vim.tbl_filter(
		function(s) return s ~= 'rust_analyzer' end,
		mason_lspconfig.get_installed_servers()
	)

	for _, server in ipairs(servers) do

		local final = deep_extend('force', opts, config[server] or {})

		lspconfig[server].setup(final)
	end
end

return M
