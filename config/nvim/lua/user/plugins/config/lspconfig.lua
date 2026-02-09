local function diagnostic_config()
	---@type vim.diagnostic.Opts
	local opts = {
		virtual_text = false,
		virtual_lines  = {
			current_line = true,
			severity = { min = vim.diagnostic.severity.ERROR },
		},
		update_in_insert = false,
		underline = true,
		severity_sort = true,
		signs = {
			text = {
				[vim.diagnostic.severity.ERROR] = '',
				[vim.diagnostic.severity.WARN] = '󰀪',
				[vim.diagnostic.severity.HINT] = '󰌶',
				[vim.diagnostic.severity.INFO] = '󰋽',
			},
		},
		float = {
			focus = false,
			focusable = true,
			border = "rounded",
			source = true,
			header = "",
		},
		jump = {
			float = true,
		},
	}
	vim.diagnostic.config(opts)
end


--- Configure defaults for vim's lua functions through closures
local function override_defaults()
	local hover = vim.lsp.buf.hover
	---@param opts vim.lsp.buf.hover.Opts?
	---@diagnostic disable-next-line: duplicate-set-field
	vim.lsp.buf.hover = function(opts)
		return hover(vim.tbl_extend('error', {
			border = "rounded",
			focusable = true
		}, opts or {}))
	end

	local signature_help = vim.lsp.buf.signature_help
	---@param opts vim.lsp.buf.signature_help.Opts?
	---@diagnostic disable-next-line: duplicate-set-field
	vim.lsp.buf.signature_help = function(opts)
		return signature_help(vim.tbl_extend('error', {
			border = "rounded",
			focusable = true
		}, opts or {}))
	end
end


local function highlight_document(client, bufnr)
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
		autocmd("TextYankPost", function() vim.hl.on_yank({}) end, nil, '*')
		autocmd("CursorHold", vim.lsp.buf.document_highlight, bufnr)
		autocmd("CursorHoldI", vim.lsp.buf.document_highlight, bufnr)
		autocmd("CursorMoved", vim.lsp.buf.clear_references, bufnr)
	end
end


return {
	{
		'neovim/nvim-lspconfig',
		lazy = false,
		keys = {
			{ "glr", vim.lsp.buf.rename,         desc = "lsp: renames all references" },
			{ "gld", vim.lsp.buf.definition,     desc = "lsp: jumps to definition" },
			{ "glD", vim.lsp.buf.declaration,    desc = "lsp: jumps to declaration" },
			{ "gls", vim.lsp.buf.signature_help, desc = "lsp: displays signature help" },
			{ "glc", vim.lsp.buf.code_action,    desc = "lsp: selects a code action" },
			{ "glf", vim.lsp.buf.format,         desc = "lsp: formats buffer" },
			{ "Ç",   "[d",                       remap = true },
			{ "ç",   "]d",                       remap = true },
		},

		---@type vim.lsp.Config
		opts = {
			on_attach = function(client, bufnr)
				highlight_document(client, bufnr)
				if client.server_capabilities.inlayHintProvider then
					vim.lsp.inlay_hint.enable(true, { bufnr = bufnr })
				end
			end
		},

		---@param opts vim.lsp.Config
		config = function(_, opts)
			diagnostic_config()
			override_defaults()

			local lsp_servers = require('user.plugins.lsp_servers')

			for name, config in pairs(lsp_servers) do
				local final = vim.tbl_deep_extend('force', opts, config)

				vim.lsp.config(name, final)
				vim.lsp.enable(name)
			end
		end,
	},
}
