local M = {}

local c = require('user.plugins.config')


local bootstrap = function()
	local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
	local lazy_url =  'https://github.com/folke/lazy.nvim.git'
	local bootstrapped = false


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
	bootstrapped = true

	return bootstrapped
end


M.setup = function()
	local bootstrapped = bootstrap()
	local lazy = require('lazy')

	lazy.setup({
		{ 'nvim-lua/plenary.nvim'  },

		{ 'neovim/nvim-lspconfig' },
		{ 'williamboman/mason.nvim', build = ':MasonUpdate' },
		{ 'williamboman/mason-lspconfig.nvim' },

		{
			'mrcjkb/rustaceanvim',
			ft = { 'rust' },
			lazy = false,
			commit = "047f9c9d8cd2861745eb9de6c1570ee0875aa795",
			config = c.rustaceanvim,
		},

		{ 'nvim-treesitter/nvim-treesitter'        , config = c.treesitter, build = ':TSUpdate' },
		{ 'nvim-treesitter/nvim-treesitter-context', config = c.context },
		{ 'nvim-treesitter/playground' },
		{ 'hiphish/rainbow-delimiters.nvim', config = c.rainbow },

		{ 'hrsh7th/nvim-cmp',    config = c.cmp },
		{ 'hrsh7th/cmp-buffer'                  },
		{ 'hrsh7th/cmp-path'                    },
		{ 'hrsh7th/cmp-cmdline'                 },
		{ 'hrsh7th/cmp-nvim-lsp-signature-help' },
		{ 'hrsh7th/cmp-nvim-lsp'                },
		{ 'hrsh7th/cmp-nvim-lua'                },
		{ 'saadparwaiz1/cmp_luasnip'            },
		{ 'onsails/lspkind.nvim'                },
		{ 'L3MON4D3/LuaSnip', dependencies = { 'rafamadriz/friendly-snippets'} },

		{ "github/copilot.vim", config = c.copilot_vim },

		{ 'nvim-telescope/telescope.nvim',
			config = c.telescope,
			tag = '0.1.4',
			dependencies = { 'nvim-lua/plenary.nvim' }
		},
		{ 'debugloop/telescope-undo.nvim'         },
		{ 'nvim-telescope/telescope-symbols.nvim' },

		{ 'kyazdani42/nvim-tree.lua'    , config = c.nvim_tree },
		{ 'nvim-lualine/lualine.nvim'   , config = c.lualine   , dependencies = { 'Mofiqul/vscode.nvim' }, },
		{ "folke/zen-mode.nvim"         , opts = c.zenmode },
		{ 'nvim-tree/nvim-web-devicons' },

		{ 'numToStr/Comment.nvim'              , config = c.comment   },
		{ 'windwp/nvim-autopairs'              , config = c.autopairs },
		{ 'lewis6991/gitsigns.nvim'            , config = c.gitsigns  },

		{ "lukas-reineke/indent-blankline.nvim", main = 'ibl', config = c.blankline },
		{ 'stevearc/dressing.nvim'             , config = c.dressing  },
		{ 'Mofiqul/vscode.nvim'                , config = c.vscode    },
	},
	{
		lockfile = vim.fn.stdpath("data") .. "/lazy-lock.json",
		ui = {
			border = "rounded"
		}
	})

end


return M
