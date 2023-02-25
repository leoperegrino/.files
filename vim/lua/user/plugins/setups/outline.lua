local outline_status_ok, outline = pcall(require, "symbols-outline")
if not outline_status_ok then
	return
end

vim.cmd[[autocmd BufEnter * if winnr('$') == 1 && exists('g:symbols_outline_state.outline_buf') && g:symbols_outline_state.outline_buf | quit | endif]]
vim.cmd[[hi! link FocusedSymbol statusline]]

outline.setup {
	highlight_hovered_item = true,
	show_guides = true,
	auto_preview = false,
	position = 'right',
	relative_width = true,
	width = 25,
	auto_close = false,
	show_numbers = false,
	show_relative_numbers = false,
	show_symbol_details = false,
	preview_bg_highlight = 'Pmenu',
	keymaps = {
		close = {"q"},
		goto_location = {"<Cr>", "O"},
		focus_location = "o",
		hover_symbol = "s",
		toggle_preview = "K",
		rename_symbol = "r",
		code_actions = "a",
		fold_all = "c",
		unfold_all = "O",
	},
	lsp_blacklist = {},
	symbol_blacklist = {},
	symbols = {
		File           = {icon = "",    hl = "TSURI"},
		Module         = {icon = "",    hl = "TSNamespace"},
		Namespace      = {icon = "",    hl = "TSNamespace"},
		Package        = {icon = "",    hl = "TSNamespace"},
		Class          = {icon = "𝓒",    hl = "TSType"},
		Method         = {icon = "ƒ",    hl = "TSMethod"},
		Property       = {icon = "",    hl = "TSMethod"},
		Field          = {icon = "",    hl = "TSField"},
		Constructor    = {icon = "",    hl = "TSConstructor"},
		Enum           = {icon = "ℰ",    hl = "TSType"},
		Interface      = {icon = "ﰮ",    hl = "TSType"},
		Function       = {icon = "",    hl = "TSFunction"},
		Variable       = {icon = "",    hl = "TSConstant"},
		Constant       = {icon = "",    hl = "TSConstant"},
		String         = {icon = "𝓐",    hl = "TSString"},
		Number         = {icon = "#",    hl = "TSNumber"},
		Boolean        = {icon = "⊨",    hl = "TSBoolean"},
		Array          = {icon = "",    hl = "TSConstant"},
		Object         = {icon = "⦿",    hl = "TSType"},
		Key            = {icon = "🔐",   hl = "TSType"},
		Null           = {icon = "NULL", hl = "TSType"},
		EnumMember     = {icon = "",    hl = "TSField"},
		Struct         = {icon = "𝓢",    hl = "TSType"},
		Event          = {icon = "🗲",    hl = "TSType"},
		Operator       = {icon = "+",    hl = "TSOperator"},
		TypeParameter  = {icon = "𝙏",    hl = "TSParameter"}
	}
}
