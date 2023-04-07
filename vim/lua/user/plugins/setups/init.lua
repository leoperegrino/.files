local M = {}


M.global = function()
	require("user.plugins.setups.blankline")
	require("user.plugins.setups.cmp")
	require("user.plugins.setups.comment")
	require("user.plugins.setups.dap")
	require("user.plugins.setups.dressing")
	require("user.plugins.setups.fidget")
	require("user.plugins.setups.gitsigns")
	require("user.plugins.setups.lualine")
	require("user.plugins.setups.nvim_tree")
	require("user.plugins.setups.outline")
	require("user.plugins.setups.context")
	require("user.plugins.setups.telescope")
	require("user.plugins.setups.toggleterm")
	require("user.plugins.setups.treesitter")
end


M.buffer = function(opts)
	require("user.plugins.setups.metals").setup(opts)
	require("user.plugins.setups.rust_tools").setup(opts)
	require("user.plugins.setups.null_ls").setup(opts)
end


M.setup = function(opts)
	M.global()
	M.buffer(opts)
end


return M
