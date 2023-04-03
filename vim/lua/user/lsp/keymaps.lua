local M = {}

local keymap = vim.keymap.set
local telescope = ":lua require('telescope.builtin')"
local lsp_buf = ":lua vim.lsp.buf"

M.lsp = function(bufnr)
	local buf_opts = { buffer = bufnr, noremap = true, silent = true }

	if vim.bo.filetype == "vim" or vim.bo.filetype == "sh" then
	elseif vim.bo.filetype == "rust" then
		keymap("n", "K", ":RustHoverActions<CR>" , buf_opts)
	else
		keymap("n", "K", ":lua vim.lsp.buf.hover()<CR>" , buf_opts)
	end

	keymap("n", "gL"  , ":lua vim.diagnostic.setloclist({open=false})<cr>" .. telescope .. ".loclist()<cr>", buf_opts)
	keymap("n", "gQ"  , ":lua vim.diagnostic.setqflist({open=false})<cr>" .. telescope .. ".quickfix()<cr>", buf_opts)
	keymap("n", "gd"  , telescope .. ".lsp_definitions()<cr>"       , buf_opts)
	keymap("n", "gI"  , telescope .. ".lsp_implementations()<cr>"   , buf_opts)
	keymap("n", "gt"  , telescope .. ".lsp_type_definitions()<cr>"  , buf_opts)
	keymap("n", "gr"  , telescope .. ".lsp_references()<cr>"        , buf_opts)
	keymap("n", "glr" , lsp_buf .. ".rename()<CR>"                  , buf_opts)
	keymap("n", "gld" , lsp_buf .. ".declaration()<CR>"             , buf_opts)
	keymap("n", "gls" , lsp_buf .. ".signature_help()<CR>"          , buf_opts)
	keymap("n", "glc" , lsp_buf .. ".code_action()<CR>"             , buf_opts)
	keymap("n", "glw" , lsp_buf .. ".add_workspace_folder()<CR>"    , buf_opts)
	keymap("n", "glW" , lsp_buf .. ".remove_workspace_folder()<CR>" , buf_opts)
	keymap("n", "glf" , lsp_buf .. ".format({async=true})<CR>"      , buf_opts)
	keymap("n", "gll" , ":lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>", buf_opts)
end

M.commands = function()
	vim.cmd[[command! Format execute 'lua vim.lsp.buf.format({async=true})']]
end

M.setup = function(bufnr)
	vim.api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")
	M.lsp(bufnr)
	M.commands()
end

return M
