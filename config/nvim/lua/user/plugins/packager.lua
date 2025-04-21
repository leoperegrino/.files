local M = {}

local c = require('user.plugins.config')


local bootstrap = function()
	local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
	local lazy_url =  'https://github.com/folke/lazy.nvim.git'

	if not vim.loop.fs_stat(lazypath) then
		vim.fn.system({
			"git",
			"clone",
			"--filter=blob:none",
			lazy_url,
			"--branch=stable", -- latest stable release
			lazypath,
		})

	end

	vim.opt.rtp:prepend(lazypath)
end


M.setup = function()
	bootstrap()
	local lazy = require('lazy')

	lazy.setup({
		{ 'neovim/nvim-lspconfig' },

		{ 'mfussenegger/nvim-dap'          , config = c.dap, },
		{ 'mfussenegger/nvim-dap-python'   , config = c.dap_python, dependencies = { 'mfussenegger/nvim-dap' }, },
		{ 'theHamsta/nvim-dap-virtual-text', config = c.dap_vt    , dependencies = { 'mfussenegger/nvim-dap' }, },
		{ "rcarriga/nvim-dap-ui"           , config = c.dapui     , dependencies = { "mfussenegger/nvim-dap", "nvim-neotest/nvim-nio" }, },

		{
			'mrcjkb/rustaceanvim',
			ft = { 'rust' },
			lazy = false,
			version = '^5',
			config = c.rustaceanvim,
		},

		{ 'nvim-treesitter/nvim-treesitter'        , config = c.treesitter, build = ':TSUpdate' },

		{ "hedyhli/outline.nvim"        , opts = {}, },
		{ 'numToStr/Comment.nvim' },

	},
	{
		lockfile = vim.fn.stdpath("data") .. "/lazy-lock.json",
		ui = {
			border = "rounded"
		}
	})

end


return M
