local core = require("user.core")
local plugins = require("user.plugins")


local on_attach = function(client, bufnr)
	core.keymaps.lsp(bufnr)
	core.lsp.highlight_document(client)
	plugins.keymaps.lsp(bufnr)
end


core.lsp.setup()
core.keymaps.setup()

plugins.packer.setup()
plugins.keymaps.plugins()
plugins.lsp.setup(on_attach)

vim.cmd[[silent! colorscheme deus]]

core.highlighting.setup()
plugins.setups.setup()
