local M = {}


M.dap        = function() require("user.plugins.config.dap").dap()    end
M.dap_python = function() require("user.plugins.config.dap").dap_python() end
M.dap_vt     = function() require("user.plugins.config.dap").dap_vt() end
M.dapui      = function() require("user.plugins.config.dap").dapui()  end


return M
