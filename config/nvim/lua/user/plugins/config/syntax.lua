return {
	{ 'nvim-treesitter/nvim-treesitter',
		lazy = false,
		build = false,
		cmd = { "TSUpdateSync", "TSUpdate", "TSInstall" },
		init = function()
			vim.wo.foldmethod = 'expr'
			vim.wo.foldexpr = 'v:lua.vim.treesitter.foldexpr()'
		end,
		keys = {
			{ "<c-space>", desc = "Increment selection" },
			{ "<c-bs>", desc = "Schrink selection" },
		},
		opts = {
			auto_install = false,
			ensure_installed = {},
			highlight = { enable = true },
			indent = { enable = true },
			incremental_selection = {
				enable = true,
				keymaps = {
					init_selection = "<C-space>",
					node_incremental = "<C-space>",
					scope_incremental = false,
					node_decremental = "<C-bs>",
				},
			},
		},
		main = 'nvim-treesitter.configs',
	},

	{ 'numToStr/Comment.nvim', opts = {}, },

	{ "hedyhli/outline.nvim",
		lazy = true,
		cmd = { "Outline", "OutlineOpen" },
		keys = {
			{ ")", "<cmd>Outline<CR>", desc = "Toggle outline" },
		},
		opts = {},
	},

}
