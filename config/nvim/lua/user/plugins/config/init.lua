local M = {}


M.cmp        = function() require("user.plugins.config.cmp")          end
M.gitsigns   = function() require("user.plugins.config.gitsigns")     end
M.lualine    = function() require("user.plugins.config.lualine")      end
M.nvim_tree  = function() require("user.plugins.config.nvim_tree")    end
M.telescope  = function() require("user.plugins.config.telescope")    end
M.dap        = function() require("user.plugins.config.dap").dap()    end
M.dap_python = function() require("user.plugins.config.dap").dap_python() end
M.dap_vt     = function() require("user.plugins.config.dap").dap_vt() end
M.dapui      = function() require("user.plugins.config.dap").dapui()  end

M.rainbow    = function() require('rainbow-delimiters.setup').setup() end

M.outline = function() require("outline").setup({})  end

M.rustaceanvim = function()
	vim.g.rustaceanvim = {
		tools = {
			float_win_config = {
				border = 'rounded'
			}
		},
		server = {
			on_attach = function(client, buffer)
				require('user.plugins.lsp').highlight_document(client, buffer)
				require('user.plugins.lsp').keymaps(client, buffer)
			end
		},
	}
end


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


M.blankline = function()
	require('ibl').setup({
		indent = {
			char = '',
			highlight = "NonText",
		},
		scope = {
			char = '╎',
			enabled = true;
			show_start = true,
			show_end = true,
			show_exact_scope = false,
			highlight = { "Label", "IblScope" },
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
	vim.wo.foldmethod = 'expr'
	vim.wo.foldexpr = 'v:lua.vim.treesitter.foldexpr()'
end


M.vscode = function()
	local vs = require('vscode')
	vs.setup({ group_overrides = { Folded = { bg = nil } }})
	vs.load()
end


return M
