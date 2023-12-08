local M = {}

local c = require('user.plugins.config')

local pack = vim.fn.stdpath('data') .. '/site/pack'


local bootstrap = function()
	local install_path = pack .. '/packer' .. '/start' .. '/packer.nvim'
	local packer_url =  'https://github.com/wbthomason/packer.nvim'
	local bootstrapped = false

	if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
		bootstrapped = vim.fn.system({
			'git',
			'clone',
			'--depth', '1',
			packer_url,
			install_path
		})

		vim.notify('Installing packer close and reopen Neovim...')
		vim.cmd([[packadd packer.nvim]])
	end

	return bootstrapped
end


M.setup = function()
	local bootstrapped = bootstrap()
	local packer = require('packer')
	local util = require('packer.util')

	packer.startup({
		function(use)
			use {
				{ 'wbthomason/packer.nvim' },
				{ 'nvim-lua/plenary.nvim'  },
			}

			use {
				{ 'neovim/nvim-lspconfig' },
				{ 'williamboman/mason.nvim', run = ':MasonUpdate' },
				{ 'williamboman/mason-lspconfig.nvim' },
				{ 'jose-elias-alvarez/null-ls.nvim', requires = 'nvim-lua/plenary.nvim' },
			}

			use { 'scalameta/nvim-metals', requires = { 'nvim-lua/plenary.nvim' } }
			use { 'simrat39/rust-tools.nvim' }

			use {
				{ 'nvim-treesitter/nvim-treesitter'        , config = c.treesitter, run = ':TSUpdate' },
				{ 'nvim-treesitter/nvim-treesitter-context', config = c.context },
				{ 'nvim-treesitter/playground' },
				{ 'HiPhish/nvim-ts-rainbow2' },
			}

			use {
				{ 'hrsh7th/nvim-cmp',    config = c.cmp },
				{ 'hrsh7th/cmp-buffer'                  },
				{ 'hrsh7th/cmp-path'                    },
				{ 'hrsh7th/cmp-cmdline'                 },
				{ 'hrsh7th/cmp-nvim-lsp-signature-help' },
				{ 'hrsh7th/cmp-nvim-lsp'                },
				{ 'hrsh7th/cmp-nvim-lua'                },
				{ 'saadparwaiz1/cmp_luasnip'            },
				{ 'L3MON4D3/LuaSnip', requires = { 'rafamadriz/friendly-snippets'} },
			}

			use {
				{ 'nvim-telescope/telescope.nvim',
					config = c.telescope,
					tag = '0.1.1',
					requires = { 'nvim-lua/plenary.nvim' }
				},
				{ 'debugloop/telescope-undo.nvim'         },
				{ 'nvim-telescope/telescope-symbols.nvim' },
			}

			use {
				{ 'kyazdani42/nvim-tree.lua'    , config = c.nvim_tree },
				{ 'nvim-lualine/lualine.nvim'   , config = c.lualine   },
				{ 'nvim-tree/nvim-web-devicons' }
			}

			use { 'numToStr/Comment.nvim'              , config = c.comment   }
			use { 'windwp/nvim-autopairs'              , config = c.autopairs }
			use { 'lewis6991/gitsigns.nvim'            , config = c.gitsigns  }

			use { "lukas-reineke/indent-blankline.nvim", main = 'ibl', config = c.blankline }
			use { 'stevearc/dressing.nvim'             , config = c.dressing  }
			use { 'Mofiqul/vscode.nvim'                , config = c.vscode    }
			use { "catppuccin/nvim", as = "catppuccin" , config = c.catppuccin }

			if bootstrapped then
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
					return util.float({ border = 'rounded' })
				end,
			}
		}
	})
end


return M
