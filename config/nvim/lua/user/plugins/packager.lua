local M = {}


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

	lazy.setup('user.plugins.config', {
		change_detection = {
			enabled = true,
			notify = false,
		},
		lockfile = vim.fn.stdpath("data") .. "/lazy-lock.json",
		ui = {
			border = "rounded"
		}
	})

end


return M
