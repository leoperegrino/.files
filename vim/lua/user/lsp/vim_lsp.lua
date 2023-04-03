local M = {}

local signs = {
	DiagnosticSignError = { text = "" , hl = "noBgDiffDelete"},
	DiagnosticSignWarn  = { text = "" , hl = "noBgDiffText"  },
	DiagnosticSignHint  = { text = "" , hl = "noBgDiffAdd"   },
	DiagnosticSignInfo  = { text = "" , hl = "noBgDiffChange"},
}

M.sign_define = function()
	for sign, config in pairs(signs) do
		vim.fn.sign_define(sign,
			{ texthl = config.hl, text = config.text, numhl = "" }
		)
	end
end


M.diagnostic_config = function()
	local config = {
		virtual_text = false,
		signs = { active = signs },
		update_in_insert = false,
		underline = false,
		severity_sort = true,
		float = {
			focus = false,
			focusable = true,
			style = "minimal",
			border = "rounded",
			source = "always",
			header = "",
			prefix = "",
		},
	}

	vim.diagnostic.config(config)
end

M.handlers = function()
	vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(
		vim.lsp.handlers.hover,
		{ border = "rounded" , focusable = true }
	)

	vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(
		vim.lsp.handlers.signature_help,
		{ border = "rounded" }
	)
end

M.lsp_highlight_document = function(client)
	if client.server_capabilities.documentHighlightProvider then
		vim.cmd(
			[[
			hi! link LspReferenceText  visual
			hi! link LspReferenceRead  visual
			hi! link LspReferenceWrite visual
			augroup lsp_document_highlight
			autocmd! * <buffer>
			autocmd! CursorHold  <buffer> lua vim.lsp.buf.document_highlight()
			autocmd! CursorHoldI <buffer> lua vim.lsp.buf.document_highlight()
			autocmd! CursorMoved <buffer> lua vim.lsp.buf.clear_references()
			autocmd! TextYankPost *       lua require('vim.highlight').on_yank({ higroup = 'Visual', timeout = 200 })
			augroup END
			]],
			false
		)
	end
end

M.setup = function()
	M.sign_define()
	M.diagnostic_config()
	M.handlers()
end

return M
