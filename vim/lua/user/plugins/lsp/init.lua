local M = {}

local config = require('user.plugins.lsp.config')
local mason = require('user.plugins.lsp.mason')


M.attach = function(opts)
	mason.setup(config, opts)
end


return M
