local status_ok, packer = pcall(require, "packer")
if not status_ok then
	return
end

packer.reset()
packer.init {
	display = {
		open_fn = function()
			return require("packer.util").float { border = "rounded" }
		end,
	},
}

packer.startup(
	function(use)
		use 'wbthomason/packer.nvim'
		use 'nvim-lua/plenary.nvim'

		use 'neovim/nvim-lspconfig'
		use 'nvim-treesitter/nvim-treesitter'
		use 'williamboman/nvim-lsp-installer'
		use 'mfussenegger/nvim-dap'
		use 'jose-elias-alvarez/null-ls.nvim'

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

		use 'simrat39/rust-tools.nvim'

		use 'numToStr/Comment.nvim'
		use 'windwp/nvim-autopairs'
		use 'akinsho/toggleterm.nvim'
		use 'kyazdani42/nvim-tree.lua'
		use 'ray-x/lsp_signature.nvim'
		use 'nvim-telescope/telescope.nvim'

		use 'ajmwagar/vim-deus'
		-- use 'norcalli/nvim-colorizer.lua'
		-- use 'tomasiser/vim-code-dark'
		-- use 'sheerun/vim-polyglot'
		use 'p00f/nvim-ts-rainbow'
		use 'stevearc/dressing.nvim'
		use 'kyazdani42/nvim-web-devicons'
		use 'simrat39/symbols-outline.nvim'
		use 'nvim-lualine/lualine.nvim'
		use 'arkav/lualine-lsp-progress'
		use "lukas-reineke/indent-blankline.nvim"
		use 'lewis6991/gitsigns.nvim'

		if PACKER_BOOTSTRAP then
			require('packer').sync()
		end
	end
)
