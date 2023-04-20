local M = {}

local signs = {
	DiagnosticSignError = { text = "" , hl = "GitSignsDelete"},
	DiagnosticSignWarn  = { text = "" , hl = "GitSignsText"  },
	DiagnosticSignHint  = { text = "" , hl = "GitSignsAdd"   },
	DiagnosticSignInfo  = { text = "" , hl = "GitSignsChange"},
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


M.highlight_document = function(client, bufnr)
	if client.server_capabilities.documentHighlightProvider then
		local augroup = vim.api.nvim_create_augroup
		local group = "lsp_document_highlight"

		local hi_yank = function() require('vim.highlight').on_yank() end
		local autocmd = function(event, callback, buffer, pattern)
			vim.api.nvim_create_autocmd(event, {
				pattern = pattern,
				group = group,
				buffer = buffer,
				callback = callback
			})
		end

		augroup(group, {})
		autocmd("TextYankPost", hi_yank, nil, '*')
		autocmd("CursorHold", vim.lsp.buf.document_highlight, bufnr)
		autocmd("CursorHoldI", vim.lsp.buf.document_highlight, bufnr)
		autocmd("CursorMoved", vim.lsp.buf.clear_references, bufnr)
	end
end


M.setup = function()
	M.sign_define()
	M.diagnostic_config()
	M.handlers()
end


return M
