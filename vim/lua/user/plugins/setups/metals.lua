local cmp_nvim_lsp = require("cmp_nvim_lsp")
local dap = require("dap")
local metals = require("metals")

local keymaps = require('user.lsp.keymaps')

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

local lsp_highlight_document = function(client)
	if client.server_capabilities.documentHighlightProvider then
		vim.api.nvim_exec(
			[[
			hi! link LspReferenceText  visual
			hi! link LspReferenceRead  visual
			hi! link LspReferenceWrite visual
			augroup lsp_document_highlight
			autocmd! * <buffer>
			autocmd! CursorHold  <buffer> lua vim.lsp.buf.document_highlight()
			autocmd! CursorHoldI <buffer> lua vim.lsp.buf.document_highlight()
			autocmd! CursorMoved <buffer> lua vim.lsp.buf.clear_references()
			autocmd! TextYankPost *       silent! lua require('vim.highlight').on_yank({higroup = 'Visual', timeout = 200})
			augroup END
			]],
			false
		)
	end
end

local metals_config = metals.bare_config()

metals_config.settings = {
	showImplicitArguments = true,
	sbtScript = 'sbt -ivy "$XDG_DATA_HOME"/ivy2 -sbt-dir "$XDG_DATA_HOME"/sbt',
	excludedPackages = { "akka.actor.typed.javadsl", "com.github.swagger.akka.javadsl" },
}

metals_config.capabilities = cmp_nvim_lsp.default_capabilities()

metals_config.on_attach = function(client, bufnr)
	keymaps.setup(bufnr)
	lsp_highlight_document(client)
	metals.setup_dap()
	vim.keymap.set('n', 'gm',
		'<cmd>lua require("telescope").extensions.metals.commands()<CR>',
		{ buffer = bufnr, noremap=true, silent=true }
	)
end

local nvim_metals_group = vim.api.nvim_create_augroup("nvim-metals", { clear = true })
vim.api.nvim_create_autocmd("FileType", {
	pattern = { "scala", "sbt", "java" },
	callback = function()
		metals.initialize_or_attach(metals_config)
	end,
	group = nvim_metals_group,
})
