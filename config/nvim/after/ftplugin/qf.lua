vim.keymap.set( "n",
	"<CR>",
	"<CR><cmd>lclose<CR><cmd>cclose<CR>",
	{
		noremap = true, buffer = true, silent = true,
		desc = "quickfix: open fix and close qf window"
	}
)
