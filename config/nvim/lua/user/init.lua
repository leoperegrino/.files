local core = require("user.core")
local plugins = require("user.plugins")


local on_attach = function(client, bufnr)
	core.on_attach(client, bufnr)
	plugins.on_attach(client, bufnr)
end


core.setup()
plugins.setup()
plugins.attach(on_attach)
