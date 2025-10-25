return {
	{ "folke/snacks.nvim",
		priority = 1000,
		lazy = false,
		opts = {
			indent = { enabled = true },
			input = { enabled = false },
			picker = { enabled = true },
		},
		keys = {
			{ "<c-r>", '<cmd>lua Snacks.picker()<CR>', desc = "Toggle Snacks" },
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
			{ "Z", "<cmd>ZenMode<CR>", desc = "Toggle ZenMode" },
		},
	},
}
