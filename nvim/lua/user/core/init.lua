local M = {}

local keymaps = require('user.core.keymaps')
local lsp = require('user.core.lsp')


M.on_attach = function(client, bufnr)
	lsp.on_attach(client, bufnr)
	keymaps.on_attach(client, bufnr)
end


M.setup = function()
	lsp.setup()
	keymaps.setup()
end


return M
