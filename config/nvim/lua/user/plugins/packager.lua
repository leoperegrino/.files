local M = {}


local function bootstrap()
	local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
	local lazy_url = 'https://github.com/folke/lazy.nvim.git'

	if not vim.uv.fs_stat(lazypath) then
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


function M.setup()
	bootstrap()

	---@type Lazy
	local lazy = require('lazy')

	---@type LazyConfig
	local config = {
		performance = {
			-- https://discourse.nixos.org/t/bundling-all-treesitter-grammar-in-neovim-while-using-lazy-nvim/74375
			-- reset_packpath = false,

			disabled_plugins = {
				"gzip",
				"matchit",
				"matchparen",
				"netrwPlugin",
				"tarPlugin",
				"tohtml",
				"tutor",
				"zipPlugin",
			},
		},
		change_detection = {
			enabled = true,
			notify = false,
		},
		ui = {
			border = "rounded"
		},
	}

	lazy.setup('user.plugins.config', config)
end


return M
