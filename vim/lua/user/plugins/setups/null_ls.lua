local null_ls_status_ok, null_ls = pcall(require, "null-ls")
if not null_ls_status_ok then
	return
end

local keymaps = require('user.core.keymaps')

local on_attach = function(client, bufnr)
	keymaps.lsp(bufnr)
end

vim.api.nvim_create_autocmd("FileType", {
	pattern = "null-ls-info",
	callback = function()
		vim.api.nvim_win_set_config(0, { border = "rounded" })
	end,
})

null_ls.setup({
	on_attach = on_attach,
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