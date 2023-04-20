local M = {}

local config = require('user.plugins.lsp.config')
local mason = require('user.plugins.lsp.mason')


M.attach = function(opts)
	mason.attach(config, opts)
end


return M
