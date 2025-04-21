local M = {}


M.dap        = function() require("user.plugins.config.dap").dap()    end
M.dap_python = function() require("user.plugins.config.dap").dap_python() end
M.dap_vt     = function() require("user.plugins.config.dap").dap_vt() end
M.dapui      = function() require("user.plugins.config.dap").dapui()  end


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


return M
