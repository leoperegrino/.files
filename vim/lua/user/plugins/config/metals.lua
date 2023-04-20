local M = {}

local utils = require("user.utils")
local dap = require("dap")
local metals = require("metals")


local dap_configuration =  {
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

local metals_settings = {
	showImplicitArguments = true,
	sbtScript = 'sbt -ivy "$XDG_DATA_HOME"/ivy2 -sbt-dir "$XDG_DATA_HOME"/sbt',
	excludedPackages = { "akka.actor.typed.javadsl", "com.github.swagger.akka.javadsl" },
}


M.autocmd = function(metals_config)
	local group = vim.api.nvim_create_augroup("nvim-metals", { clear = true })
	local pattern = { "scala", "sbt", "java" }
	local callback = function()
		metals.initialize_or_attach(metals_config)
	end

	vim.api.nvim_create_autocmd("FileType", {
		pattern = pattern,
		callback = callback,
		group = group,
	})
end


M.metals_attach = function(default_attach)
	return function(client, bufnr)
		local buf_opts = { buffer = bufnr, noremap=true, silent=true }

		default_attach(client, bufnr)
		metals.setup_dap()

		vim.keymap.set('n', 'gm',
			'<cmd>lua require("telescope").extensions.metals.commands()<CR>',
			buf_opts
		)
		vim.keymap.set('n', 'gw',
			'<cmd>lua require("metals").hover_worksheet()<CR>',
			buf_opts
		)
	end
end


M.attach = function(opts)
	dap.configurations.scala = dap_configuration

	local default_attach = opts.on_attach
	local metals_config = metals.bare_config()

	metals_config = utils.merge(metals_config, opts)
	metals_config.settings = metals_settings
	metals_config.on_attach = M.metals_attach(default_attach)

	M.autocmd(metals_config)
end


return M
