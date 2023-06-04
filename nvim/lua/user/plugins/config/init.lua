local M = {}


M.cmp        = function() require("user.plugins.config.cmp")        end
M.gitsigns   = function() require("user.plugins.config.gitsigns")   end
M.lualine    = function() require("user.plugins.config.lualine")    end
M.noice      = function() require("user.plugins.config.noice")      end
M.nvim_tree  = function() require("user.plugins.config.nvim_tree")  end
M.telescope  = function() require("user.plugins.config.telescope")  end

M.fidget     = function() require('fidget').setup()	                end
M.comment    = function() require('Comment').setup()                end
M.autopairs  = function() require('nvim-autopairs').setup()         end
M.context    = function() require('treesitter-context').setup()     end


M.blankline  = function()
	require('indent_blankline').setup({
		show_current_context = true,
		show_current_context_start = false
	})
end


M.dressing = function()
	require('dressing').setup({
		input = { win_options = { winblend = 0 }}
	})
end


M.treesitter = function()
	require('nvim-treesitter.configs').setup({
		rainbow = { enable = true },
		playground = { enable = true },
		highlight = { enable = true },
	})
	vim.o.foldmethod = 'expr'
	vim.o.foldexpr = 'nvim_treesitter#foldexpr()'
	vim.o.foldenable = false
end


M.catppuccin = function()
	require('catppuccin').setup({
        no_italic = true,
		flavour = "mocha",
		custom_highlights = function(_)
			return { Folded = { bg = 'NONE' } }
		end
	})
	-- vim.cmd.colorscheme('catppuccin')
end


M.vscode = function()
	local vs = require('vscode')
	vs.setup({ group_overrides = { Folded = { bg = nil } }})
	vs.load()
end


M.standalone = function(opts)
	require("user.plugins.config.metals").setup(vim.deepcopy(opts))
	require("user.plugins.config.rust_tools").setup(vim.deepcopy(opts))
	require("user.plugins.config.null_ls").setup(vim.deepcopy(opts))
end


M.mason = function(opts)
	local mason = require("user.plugins.config.mason")
	local config = require('user.plugins.config.servers')
	mason.setup(config, vim.deepcopy(opts))
end


return M
