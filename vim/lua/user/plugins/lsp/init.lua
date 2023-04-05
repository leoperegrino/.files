local M = {}

local my_config = require('user.plugins.lsp.config')
local mason = require('user.plugins.lsp.mason')


M.setup = function(on_attach)
	mason.setup(my_config, on_attach)
end


return M
