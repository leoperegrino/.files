local configs = require("nvim-treesitter.configs")

vim.o.foldmethod = 'expr'
vim.o.foldexpr = 'nvim_treesitter#foldexpr()'

configs.setup {
	ensure_installed = "all",
	sync_install = false,
	ignore_install = { "" },
	autopairs = {
		enable = true,
	},
	highlight = {
		enable = true,
		disable = { "" },
		additional_vim_regex_highlighting = false,
	},
	indent = { enable = true, disable = { "python" } },
	context_commentstring = {
		enable = true,
		enable_autocmd = false,
	},
		rainbow = {
			enable = true,
			-- disable = {},
			extended_mode = true,
			-- max_file_lines = nil,
			-- colors = {},
			-- termcolors = {}
		}
}
