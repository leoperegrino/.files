local M = {}

local packager = require('user.plugins.packager')
local keymaps = require('user.plugins.keymaps')
local lsp = require('user.plugins.lsp')


M.setup = function()
	packager.setup()
	keymaps.setup()
	lsp.setup(keymaps.lsp)
end


return M
