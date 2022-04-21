require('user.lsp.lspconfig')

local signs = {
	{ name = "DiagnosticSignError", text = "" , hl = "noBgDiffDelete"},
	{ name = "DiagnosticSignWarn" , text = "" , hl = "noBgDiffText"  },
	{ name = "DiagnosticSignHint" , text = "" , hl = "noBgDiffAdd"   },
	{ name = "DiagnosticSignInfo" , text = "" , hl = "noBgDiffChange"},
}

for _, sign in ipairs(signs) do
    vim.fn.sign_define(sign.name,
		{ texthl = sign.hl, text = sign.text, numhl = "" }
	)
end

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

vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(
	vim.lsp.handlers.hover,
	{ border = "rounded" ,
	focusable = true }
)

vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(
	vim.lsp.handlers.signature_help,
	{ border = "rounded" }
)
