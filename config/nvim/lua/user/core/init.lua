local M = {}

local filetype = require('user.core.filetype')
local keymaps = require('user.core.keymaps')
local options = require('user.core.options')
local autocmds = require('user.core.autocmds')


function M.setup()
	options.setup()
	autocmds.setup()
	keymaps.setup()
	filetype.setup()
end


return M
