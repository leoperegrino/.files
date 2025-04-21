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

		{ 'nvim-tree/nvim-tree.lua'    , config = c.nvim_tree },
		{ 'nvim-tree/nvim-web-devicons' },
		{
			's1n7ax/nvim-window-picker',
			name = 'window-picker',
			event = 'VeryLazy',
			version = '2.*',
			opts = c.window_picker,
		},

		{ 'nvim-lualine/lualine.nvim'   , config = c.lualine   , dependencies = { 'Mofiqul/vscode.nvim' }, },

		{ "folke/zen-mode.nvim"         , opts = c.zenmode },
		{ "hedyhli/outline.nvim"        , opts = {}, },
		{ 'numToStr/Comment.nvim' },

		{
			"folke/snacks.nvim",
			priority = 1000,
			lazy = false,
			opts = {
				indent = { enabled = true },
				input = { enabled = true },
				picker = { enabled = true },
			},
		},
		{ 'hiphish/rainbow-delimiters.nvim', },
		{ 'Mofiqul/vscode.nvim', opts = c.vscode.opts, init = c.vscode.init, },
	},
	{
		lockfile = vim.fn.stdpath("data") .. "/lazy-lock.json",
		ui = {
			border = "rounded"
		}
	})

end


return M
