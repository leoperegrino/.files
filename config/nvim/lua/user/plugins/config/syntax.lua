return {
	{ 'nvim-treesitter/nvim-treesitter',
		build = ':TSUpdate',
		init = function()
			vim.wo.foldmethod = 'expr'
			vim.wo.foldexpr = 'v:lua.vim.treesitter.foldexpr()'
		end,
		opts = {
			auto_install = true,
			ignore_install = { "xml" },
			highlight = { enable = true },
		},
		main = 'nvim-treesitter.configs',
	},

	{ 'numToStr/Comment.nvim', opts = {}, },

	{ "hedyhli/outline.nvim",
		lazy = true,
		cmd = { "Outline", "OutlineOpen" },
		keys = {
			{ "<F11>", "<cmd>Outline<CR>", desc = "Toggle outline" },
		},
		opts = {},
	},

}
