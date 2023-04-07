local M = {}

local dap = require("dap")
local metals = require("metals")


dap.configurations.scala = {
	{
		type = "scala",
		request = "launch",
		name = "RunOrTest",
		metals = {
			runType = "runOrTestFile",
			--args = { "firstArg", "secondArg", "thirdArg" }, -- here just as an example
		},
	},
	{
		type = "scala",
		request = "launch",
		name = "Test Target",
		metals = {
			runType = "testTarget",
		},
	},
}


M.setup = function(opts)
	local metals_config = metals.bare_config()

	metals_config.settings = {
		showImplicitArguments = true,
		sbtScript = 'sbt -ivy "$XDG_DATA_HOME"/ivy2 -sbt-dir "$XDG_DATA_HOME"/sbt',
		excludedPackages = { "akka.actor.typed.javadsl", "com.github.swagger.akka.javadsl" },
	}

	metals_config.on_attach = function(_, bufnr)
		opts.on_attach()
		metals.setup_dap()
		vim.keymap.set('n', 'gm',
			'<cmd>lua require("telescope").extensions.metals.commands()<CR>',
			{ buffer = bufnr, noremap=true, silent=true }
		)
	end

	metals_config.capabilities = opts.capabilities

	local nvim_metals_group = vim.api.nvim_create_augroup("nvim-metals", { clear = true })

	vim.api.nvim_create_autocmd("FileType", {
		pattern = { "scala", "sbt", "java" },
		callback = function()
			metals.initialize_or_attach(metals_config)
		end,
		group = nvim_metals_group,
	})
end


return M
