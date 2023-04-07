local M = {}

M.lsp = require('user.plugins.lsp')
M.setups = require('user.plugins.setups')
M.packer = require('user.plugins.packer')
M.keymaps = require('user.plugins.keymaps')


M.make_opts = function(on_attach)
	local cmp_nvim_lsp = require("cmp_nvim_lsp")
	local capabilities = vim.lsp.protocol.make_client_capabilities()
	capabilities = cmp_nvim_lsp.default_capabilities(capabilities)
	capabilities.offsetEncoding = { "utf-16" }

	return {
		capabilities = capabilities,
		on_attach = on_attach
	}
end


return M
