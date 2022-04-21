local lsp_installer_ok, lsp_installer = pcall(require, "nvim-lsp-installer")
if not lsp_installer_ok then
	return
end

local cmp_nvim_lsp_ok, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
if not cmp_nvim_lsp_ok then
	return
end

local keymaps = require('user.core.keymaps')

local function lsp_highlight_document(client)
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

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = cmp_nvim_lsp.update_capabilities(capabilities)

local servers_opts = require('user.lsp.servers_opts')

lsp_installer.on_server_ready(function(server)
	local opts = {
		on_attach = on_attach,
		capabilities = capabilities,
	}

	if server.name == "sumneko_lua" then
		servers_opts.sumneko_lua(server, opts)

	elseif server.name == "rust_analyzer" then
		servers_opts.rust_analyzer(server, opts)

	elseif server.name == "pylsp" then
		servers_opts.pylsp(server, opts)

	else
		server:setup(opts)
	end
end)
