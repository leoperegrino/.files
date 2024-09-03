local core = require("user.core")
local plugins = require("user.plugins")
local safe_call = require("user.utils").safe_call


local on_attach = function(client, bufnr)
	core.on_attach(client, bufnr)
	plugins.on_attach(client, bufnr)
end

safe_call(core.setup)
safe_call(plugins.setup)
safe_call(plugins.attach, on_attach)
