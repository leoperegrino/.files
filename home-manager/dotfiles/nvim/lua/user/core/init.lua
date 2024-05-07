local M = {}

local keymaps = require('user.core.keymaps')
local lsp = require('user.core.lsp')
local options = require('user.core.options')
local autocmds = require('user.core.autocmds')


M.on_attach = function(client, bufnr)
	lsp.on_attach(client, bufnr)
	keymaps.on_attach(client, bufnr)
end


M.setup = function()
	options.setup()
	autocmds.setup()
	lsp.setup()
	keymaps.setup()
end


return M
