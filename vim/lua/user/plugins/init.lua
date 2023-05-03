local M = {}

local lsp = require('user.plugins.lsp')
local config = require('user.plugins.config')
local packer = require('user.plugins.packer')
local keymaps = require('user.plugins.keymaps')


M.on_attach = function(client, bufnr)
	keymaps.on_attach(client, bufnr)
end


M.setup = function()
	packer.setup()
	keymaps.setup()
end


M.attach = function(on_attach)
	local cmp_nvim_lsp = require("cmp_nvim_lsp")
	local capabilities = vim.lsp.protocol.make_client_capabilities()

	capabilities = cmp_nvim_lsp.default_capabilities(capabilities)
	capabilities.offsetEncoding = { "utf-16" }

	local opts = {
		capabilities = capabilities,
		on_attach = on_attach
	}

	lsp.attach(opts)
	config.attach(opts)
end


return M
