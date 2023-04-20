local M = {}


M.setup = function()
	require("user.plugins.config.blankline")
	require("user.plugins.config.cmp")
	require("user.plugins.config.comment")
	require("user.plugins.config.dap")
	require("user.plugins.config.dressing")
	require("user.plugins.config.fidget")
	require("user.plugins.config.gitsigns")
	require("user.plugins.config.lualine")
	require("user.plugins.config.nvim_tree")
	require("user.plugins.config.outline")
	require("user.plugins.config.context")
	require("user.plugins.config.telescope")
	require("user.plugins.config.toggleterm")
	require("user.plugins.config.treesitter")
end


M.attach = function(opts)
	require("user.plugins.config.metals").attach(opts)
	require("user.plugins.config.rust_tools").attach(opts)
	require("user.plugins.config.null_ls").attach(opts)
end


return M
