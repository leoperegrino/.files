local M = {}

local packager = require('user.plugins.packager')
local lsp = require('user.plugins.lsp')


M.setup = function()
	packager.setup()
	lsp.setup()
end


return M
