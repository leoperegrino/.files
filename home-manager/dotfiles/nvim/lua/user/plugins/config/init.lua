local M = {}


M.cmp        = function() require("user.plugins.config.cmp")          end
M.gitsigns   = function() require("user.plugins.config.gitsigns")     end
M.lualine    = function() require("user.plugins.config.lualine")      end
M.nvim_tree  = function() require("user.plugins.config.nvim_tree")    end
M.telescope  = function() require("user.plugins.config.telescope")    end

M.fidget     = function() require('fidget').setup()                   end
M.comment    = function() require('Comment').setup()                  end
M.autopairs  = function() require('nvim-autopairs').setup()           end
M.context    = function() require('treesitter-context').setup()       end
M.rainbow    = function() require('rainbow-delimiters.setup').setup() end


M.zenmode  = {
	plugins = {
		options = {
			laststatus = 0,
		},
		gitsigns = {
			enabled = false
		},
	},
}


M.blankline  = function()
	require('ibl').setup({
		scope = {
			show_start = false,
			show_end = false,
		}
	})
end


M.dressing = function()
	require('dressing').setup({
		input = { win_options = { winblend = 0 }}
	})
end


M.treesitter = function()
	require('nvim-treesitter.configs').setup({
		auto_install = true,
		ignore_install = { "xml" },
		playground = { enable = true },
		highlight = { enable = true },
	})
	vim.o.foldmethod = 'expr'
	vim.o.foldexpr = 'nvim_treesitter#foldexpr()'
	vim.o.foldenable = false
end


M.vscode = function()
	local vs = require('vscode')
	vs.setup({ group_overrides = { Folded = { bg = nil } }})
	vs.load()
end


M.standalone = function(opts)
	require("user.plugins.config.metals").setup(vim.deepcopy(opts))
	require("user.plugins.config.null_ls").setup(vim.deepcopy(opts))
end


M.mason = function(opts)
	local mason = require("user.plugins.config.mason")
	local config = require('user.plugins.config.servers')
	mason.setup(config, vim.deepcopy(opts))
end


return M
