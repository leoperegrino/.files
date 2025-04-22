return {
	{ 'mrcjkb/rustaceanvim',
		ft = { 'rust' },
		lazy = false,
		version = '^5',
		opts = {
			tools = {
				float_win_config = {
					border = 'rounded'
				}
			},
			server = {
				on_attach = function(_, buffer)
					vim.keymap.set("n", "K",
						function() vim.cmd.RustLsp({'hover', 'actions'}) end,
						{ buffer = buffer, desc = 'rustacean: hover' }
					)
					vim.keymap.set("n", "<leader>a",
						function() vim.cmd.RustLsp('codeAction') end,
						{ buffer = buffer, desc = 'rustacean: codeAction' }
					)
				end
			},
		},
		config = function(_, opts)
			vim.g.rustaceanvim = vim.tbl_deep_extend("keep", vim.g.rustaceanvim or {}, opts or {})
		end,
	},
}
