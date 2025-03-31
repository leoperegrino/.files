local bufnr = vim.api.nvim_get_current_buf()

vim.keymap.set("n", "q",
	function() vim.api.nvim_win_close(0, false) end,
	{ silent = true, buffer = bufnr }
)
