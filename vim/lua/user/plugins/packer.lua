local M = {}

local packer = require("packer")
local util = require("packer.util")
local pack = vim.fn.stdpath('data') .. '/site/pack'


M.bootstrap = function()
	local install_path = util.join_paths(pack, 'packer', 'start', 'packer.nvim')
	local packer_url =  'https://github.com/wbthomason/packer.nvim'

	if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
		PACKER_BOOTSTRAP = vim.fn.system({
				'git',
				'clone',
				'--depth', '1',
				packer_url,
				install_path
			})

		print("Installing packer close and reopen Neovim...")
		vim.cmd([[packadd packer.nvim]])
	end
end


M.startup = function()
	packer.startup({
		function(use)
			use 'wbthomason/packer.nvim'
			use 'nvim-lua/plenary.nvim'

			use 'neovim/nvim-lspconfig'
			use "williamboman/mason.nvim"
			use "williamboman/mason-lspconfig.nvim"
			use { 'nvim-treesitter/nvim-treesitter', run = ':TSUpdate' }
			use 'nvim-treesitter/nvim-treesitter-context'
			use 'jose-elias-alvarez/null-ls.nvim'

			use 'mfussenegger/nvim-dap'
			use 'rcarriga/nvim-dap-ui'
			use 'theHamsta/nvim-dap-virtual-text'
			use 'mfussenegger/nvim-dap-python'

			use 'hrsh7th/nvim-cmp'
			use 'hrsh7th/cmp-buffer'
			use 'hrsh7th/cmp-path'
			use 'hrsh7th/cmp-cmdline'
			use 'hrsh7th/cmp-nvim-lsp-signature-help'
			use 'hrsh7th/cmp-nvim-lsp'
			use 'hrsh7th/cmp-nvim-lua'
			use 'L3MON4D3/LuaSnip'
			use 'saadparwaiz1/cmp_luasnip'
			use 'rafamadriz/friendly-snippets'

			use { 'scalameta/nvim-metals', requires = { "nvim-lua/plenary.nvim" } }
			use 'simrat39/rust-tools.nvim'

			use 'numToStr/Comment.nvim'
			use { 'windwp/nvim-autopairs', config = function() require("nvim-autopairs").setup() end }
			use 'akinsho/toggleterm.nvim'
			use 'kyazdani42/nvim-tree.lua'
			use 'nvim-telescope/telescope.nvim'
			use 'nvim-telescope/telescope-symbols.nvim'
			use 'debugloop/telescope-undo.nvim'

			-- use 'ajmwagar/vim-deus'
			use { 'Mofiqul/vscode.nvim',
				config = function()
					local vs = require('vscode')
					vs.setup({ group_overrides = { Folded = { bg = nil } }})
					vs.load()
				end
			}
			use 'p00f/nvim-ts-rainbow'
			use 'stevearc/dressing.nvim'
			use 'kyazdani42/nvim-web-devicons'
			use 'simrat39/symbols-outline.nvim'
			use 'nvim-lualine/lualine.nvim'
			use 'j-hui/fidget.nvim'
			use "lukas-reineke/indent-blankline.nvim"
			use 'lewis6991/gitsigns.nvim'

			if PACKER_BOOTSTRAP then
				packer.sync()
			end
		end,
		config = {
			-- https://github.com/wbthomason/packer.nvim/issues/201#issuecomment-1011066526
			compile_path = util.join_paths(
				pack, 'loader', 'start', 'packer.nvim', 'plugin', 'packer.lua'
			),
			display = {
				open_fn = function()
					return util.float({ border = "rounded" })
				end,
			}
		}
	})
end


M.setup = function()
	M.bootstrap()
	M.startup()
end


return M
