local fn = vim.fn
local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
local packer_url =  'https://github.com/wbthomason/packer.nvim'

if fn.empty(fn.glob(install_path)) > 0 then
	PACKER_BOOTSTRAP = fn.system({
			'git',
			'clone',
			'--depth', '1',
			packer_url,
			install_path
		})

	print "Installing packer close and reopen Neovim..."
	vim.cmd [[packadd packer.nvim]]
end

vim.cmd [[
	augroup packer_user_config
	autocmd!
	autocmd BufWritePost plugins.lua source <afile> | PackerSync
	augroup end
]]
