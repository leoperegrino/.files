local M = {}

local null_ls = require("null-ls")


M.setup = function(opts)
	vim.api.nvim_create_autocmd("FileType", {
		pattern = "null-ls-info",
		callback = function()
			vim.api.nvim_win_set_config(0, { border = "rounded" })
		end,
	})

	null_ls.setup({
		on_attach = opts.on_attach,
		sources = {
			null_ls.builtins.code_actions.gitsigns,
			null_ls.builtins.diagnostics.gitlint,
			null_ls.builtins.code_actions.shellcheck,
			-- null_ls.builtins.diagnostics.zsh,
			-- null_ls.builtins.diagnostics.luacheck,
			-- null_ls.builtins.diagnostics.mypy,
			null_ls.builtins.diagnostics.tsc,
			null_ls.builtins.formatting.autopep8,
			null_ls.builtins.formatting.black,
			null_ls.builtins.formatting.isort,
			-- null_ls.builtins.formatting.jq,
			-- null_ls.builtins.hover.dictionary,
			-- null_ls.builtins.formatting.stylua,
			-- null_ls.builtins.diagnostics.eslint,
			-- null_ls.builtins.completion.spell,
		},
	})
end


return M
