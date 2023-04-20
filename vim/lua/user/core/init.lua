local M = {}

M.keymaps = require('user.core.keymaps')
M.lsp = require('user.core.lsp')


M.on_attach = function(client, bufnr)
	M.lsp.on_attach(client, bufnr)
	M.keymaps.on_attach(client, bufnr)
end


M.setup = function()
	M.lsp.setup()
	M.keymaps.setup()
end


return M
