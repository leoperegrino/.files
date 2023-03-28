local M = {}

local myconfig = require('user.lsp.servers_opts')

local cmp_nvim_lsp = require("cmp_nvim_lsp")
local lspconfig = require("lspconfig")
local mason = require("mason")
local mason_lspconfig = require("mason-lspconfig")

vim.api.nvim_create_autocmd("FileType", {
	pattern = {"mason", "lsp-installer", "lspinfo"},
	callback = function()
		vim.api.nvim_win_set_config(0, { border = "rounded" })
	end,
})

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = cmp_nvim_lsp.default_capabilities(capabilities)
capabilities.offsetEncoding = { "utf-16" }


M.setup = function(on_attach)
	mason.setup{}
	mason_lspconfig.setup{}

	local opts = {
		on_attach = on_attach,
		capabilities = capabilities,
	}

	local servers = mason_lspconfig.get_installed_servers()

	for _, server in ipairs(servers) do

		if myconfig[server] then
			myconfig[server].setup(opts, lspconfig)
		else
			lspconfig[server].setup(opts)
		end
	end
end

return M
