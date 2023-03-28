local blankline = require("indent_blankline")

vim.opt.list = true
-- vim.cmd [[highlight IndentBlanklineIndent1 ctermbg=233 gui=nocombine]]
-- vim.cmd [[highlight IndentBlanklineIndent2 ctermbg=235 gui=nocombine]]

blankline.setup {
	show_current_context = true,
	show_current_context_start = false,
	-- char_list_blankline = {'|', '¦', '┆', '┊'},
	filetype_exclude = {
		"text",
		"lspinfo",
		"packer",
		"checkhealth",
		"help",
		"lsp-installer",
		"",
	},
	show_trailing_blankline_indent = false,
}
