return {
	{ "folke/snacks.nvim",
		priority = 1000,
		lazy = false,
		opts = {
			indent = { enabled = true },
			input = { enabled = true },
			picker = { enabled = true },
		},
	},

	{ 'hiphish/rainbow-delimiters.nvim' },

	{ 'Mofiqul/vscode.nvim',
		opts = {
			group_overrides = { Folded = { bg = nil } }
		},
		config = function(_, opts)
			local vscode = require('vscode')
			vscode.setup(opts)
			vscode.load()
		end,
	},

	{ "folke/zen-mode.nvim",
		opts = {
			plugins = {
				options = { laststatus = 0, },
				gitsigns = { enabled = false },
			},
		},
		keys = {
			{ "<F12>", "<cmd>ZenMode<CR>", desc = "Toggle ZenMode" },
		},
	},
}
