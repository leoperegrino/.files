local lsp_installer_ok, lsp_installer = pcall(require, "nvim-lsp-installer")
if not lsp_installer_ok then
	return
end

lsp_installer.setup{}
local lspconfig = require("lspconfig")

vim.api.nvim_create_autocmd("FileType", {
	pattern = {"lsp-installer", "lspinfo"},
	callback = function()
		vim.api.nvim_win_set_config(0, { border = "rounded" })
	end,
})

local cmp_nvim_lsp_ok, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
if not cmp_nvim_lsp_ok then
	return
end

local keymaps = require('user.core.keymaps')
local servers_opts = require('user.lsp.servers_opts')
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = cmp_nvim_lsp.update_capabilities(capabilities)
capabilities.offsetEncoding = { "utf-16" }


local lsp_highlight_document = function(client)
	if client.resolved_capabilities.document_highlight then
		vim.api.nvim_exec(
			[[
			hi! link LspReferenceText  visual
			hi! link LspReferenceRead  visual
			hi! link LspReferenceWrite visual
			augroup lsp_document_highlight
			autocmd! * <buffer>
			autocmd! CursorHold  <buffer> lua vim.lsp.buf.document_highlight()
			autocmd! CursorHoldI <buffer> lua vim.lsp.buf.document_highlight()
			autocmd! CursorMoved <buffer> lua vim.lsp.buf.clear_references()
			autocmd! TextYankPost *       silent! lua require('vim.highlight').on_yank({higroup = 'Visual', timeout = 200})
			augroup END
			]],
			false
		)
	end
end

local on_attach = function(client, bufnr)
	keymaps.lsp(bufnr)
	lsp_highlight_document(client)
end

local servers = lsp_installer.get_installed_servers()

local opts = {
	on_attach = on_attach,
	capabilities = capabilities,
}

for _, server in ipairs(servers) do

	local server_opt = servers_opts[server.name]

	if server_opt then
		server_opt(server, opts)
	else
		lspconfig[server.name].setup(opts)
	end
end
