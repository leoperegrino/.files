local M = {}

local signs = {
	DiagnosticSignError = { text = "" , hl = "GitSignsDelete"},
	DiagnosticSignWarn  = { text = "󰀪" , hl = "GitSignsText"  },
	DiagnosticSignHint  = { text = "󰌶" , hl = "GitSignsAdd"   },
	DiagnosticSignInfo  = { text = "󰋽" , hl = "GitSignsChange"},
}


local sign_define = function()
	for sign, config in pairs(signs) do
		vim.fn.sign_define(sign,
			{ texthl = config.hl, text = config.text, numhl = "" }
		)
	end
end


local diagnostic_config = function()
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


local handlers = function()
	vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(
		vim.lsp.handlers.hover,
		{ border = "rounded" , focusable = true }
	)

	vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(
		vim.lsp.handlers.signature_help,
		{ border = "rounded" }
	)
end


local highlight_document = function(client, bufnr)
	if client.server_capabilities.documentHighlightProvider then
		local augroup = vim.api.nvim_create_augroup
		local group = "lsp_document_highlight"

		local autocmd = function(event, callback, buffer, pattern)
			vim.api.nvim_create_autocmd(event, {
				pattern = pattern,
				group = group,
				buffer = buffer,
				callback = callback
			})
		end

		augroup(group, {})
		autocmd("TextYankPost", vim.highlight.on_yank, nil, '*')
		autocmd("CursorHold", vim.lsp.buf.document_highlight, bufnr)
		autocmd("CursorHoldI", vim.lsp.buf.document_highlight, bufnr)
		autocmd("CursorMoved", vim.lsp.buf.clear_references, bufnr)
	end
end


local keymaps = function(_, bufnr)
	local keymap_with = require('user.utils').keymap_with

	local keymap = keymap_with({
		noremap = true,
		silent = true
	})

	local bufmap = keymap_with({
		buffer = bufnr,
		noremap = true,
	})

	if vim.bo.filetype ~= "vim" and vim.bo.filetype ~= "sh" then
		bufmap("n", "K"   , vim.lsp.buf.hover)
	end

	keymap("n", "[d"         , vim.diagnostic.goto_prev , "lsp: jumps to previous diagnostic")
	keymap("n", "Ç"          , vim.diagnostic.goto_prev , "lsp: jumps to previous diagnostic")
	keymap("n", "]d"         , vim.diagnostic.goto_next , "lsp: jumps to next diagnostic"    )
	keymap("n", "ç"          , vim.diagnostic.goto_next , "lsp: jumps to next diagnostic"    )
	keymap("n", "<leader>eq" , vim.diagnostic.setloclist, "lsp: add buffer diagnostics to the location list")

	bufmap("n", "glr" , vim.lsp.buf.rename                 , "lsp: renames all references"  )
	bufmap("n", "gld" , vim.lsp.buf.declaration            , "lsp: jumps to declaration"    )
	bufmap("n", "gls" , vim.lsp.buf.signature_help         , "lsp: displays signature help" )
	bufmap("n", "glc" , vim.lsp.buf.code_action            , "lsp: selects a code action"   )
	bufmap("n", "glw" , vim.lsp.buf.add_workspace_folder   , "lsp: add folder to workspace" )
	bufmap("n", "glW" , vim.lsp.buf.remove_workspace_folder, "lsp: rm folder from workspace")
	bufmap("n", "glf" , vim.lsp.buf.format                 , "lsp: formats buffer"          )
	bufmap("n", "gll" , "<Cmd>= vim.lsp.buf.list_workspace_folders()<CR>", "lsp: list folders in workspace")

	local ok, telescope = pcall(require, 'telescope.builtin')
	if ok then
		bufmap("n", "gd"  , telescope.lsp_definitions     , "telescope lsp: lsp definitions")
		bufmap("n", "gI"  , telescope.lsp_implementations , "telescope lsp: lsp implementations")
		bufmap("n", "gt"  , telescope.lsp_type_definitions, "telescope lsp: lsp type definitions")
		bufmap("n", "gr"  , telescope.lsp_references      , "telescope lsp: lsp references")
		bufmap("n", "gL"  , function() vim.diagnostic.setloclist({ open = false }) telescope.loclist()  end, "telescope lsp: location list")
		bufmap("n", "gQ"  , function() vim.diagnostic.setqflist({ open = false })  telescope.quickfix() end, "telescope lsp: quickfix list")
	end
end


local servers = function()
	local lspconfig = require("lspconfig")
	local lsp_servers = require('user.plugins.lsp_servers')

	local capabilities
	local ok, cmp = pcall(require, 'cmp_nvim_lsp')
	if ok then
		capabilities = cmp.default_capabilities()
	end

	local opts = {
		capabilities = capabilities,
		on_attach = function(client, bufnr)
			keymaps(client, bufnr)
			highlight_document(client, bufnr)
		end
	}

	for name, config in pairs(lsp_servers) do

		local final = vim.tbl_deep_extend('force', opts, config)

		lspconfig[name].setup(final)
	end
end


M.setup = function()
	sign_define()
	diagnostic_config()
	handlers()
	servers()
end


return M
