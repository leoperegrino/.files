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
				on_attach = function(client, buffer)
					local user_lspconfig = require('user.plugins.config.lspconfig')
					local user_opts = user_lspconfig[1].opts()

					user_opts.on_attach(client, buffer)

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
