local M = {}


M.cmp        = function() require("user.plugins.config.cmp")        end
M.gitsigns   = function() require("user.plugins.config.gitsigns")   end
M.lualine    = function() require("user.plugins.config.lualine")    end
M.nvim_tree  = function() require("user.plugins.config.nvim_tree")  end
M.telescope  = function() require("user.plugins.config.telescope")  end
M.fidget     = function() require('fidget').setup()	                end
M.comment    = function() require('Comment').setup()                end
M.autopairs  = function() require('nvim-autopairs').setup()         end
M.context    = function() require('treesitter-context').setup()     end
M.blankline  = function() require('indent_blankline').setup({ show_current_context = true, show_current_context_start = true }) end
M.dressing   = function() require('dressing').setup({ input = { win_options = { winblend = 0 }}}) end


M.treesitter = function()
	require('nvim-treesitter.configs').setup({ highlight = { enable = true }})
	vim.cmd[[
	set foldmethod=expr
	set foldexpr=nvim_treesitter#foldexpr()
	set nofoldenable
	]]
end


M.vscode     = function()
	local vs = require('vscode')
	vs.setup({ group_overrides = { Folded = { bg = nil } }})
	vs.load()
end



M.attach = function(opts)
	require("user.plugins.config.metals").attach(opts)
	require("user.plugins.config.rust_tools").attach(opts)
	require("user.plugins.config.null_ls").attach(opts)
end


return M
