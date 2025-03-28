local M = {}

local keymaps = require('user.core.keymaps')
local options = require('user.core.options')
local autocmds = require('user.core.autocmds')


M.setup = function()
	options.setup()
	autocmds.setup()
	keymaps.setup()
end


return M
