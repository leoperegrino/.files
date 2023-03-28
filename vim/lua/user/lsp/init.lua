local vim_lsp = require('user.lsp.vim_lsp')
local keymaps = require('user.lsp.keymaps')
local lsp_installer = require('user.lsp.lsp_installer')

local on_attach = function(client, bufnr)
	keymaps.setup(bufnr)
	vim_lsp.lsp_highlight_document(client)
end

vim_lsp.setup()
lsp_installer.setup(on_attach)
