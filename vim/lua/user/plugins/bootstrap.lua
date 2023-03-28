local install_path = vim.fn.stdpath('state')..'/site/pack/packer/start/packer.nvim'
local packer_url =  'https://github.com/wbthomason/packer.nvim'

if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
	PACKER_BOOTSTRAP = vim.fn.system({
			'git',
			'clone',
			'--depth', '1',
			packer_url,
			install_path
		})

	print "Installing packer close and reopen Neovim..."
	vim.cmd [[packadd packer.nvim]]
end
