local M = {}

local telescope = ":lua require('telescope.builtin')"


M.lsp = function(bufnr)
	local buf_opts = { buffer = bufnr, noremap = true, silent = true }
	local diagnostic = ":lua vim.diagnostic"
	local bufmap = function(mode, key, map) vim.keymap.set(mode, key, map, buf_opts) end

	bufmap("n", "gD"  , ":vsplit<CR>" .. telescope .. ".lsp_definitions()<cr>")
	bufmap("n", "gd"  , telescope .. ".lsp_definitions()<cr>")
	bufmap("n", "gI"  , telescope .. ".lsp_implementations()<cr>")
	bufmap("n", "gt"  , telescope .. ".lsp_type_definitions()<cr>")
	bufmap("n", "gr"  , telescope .. ".lsp_references()<cr>")
	bufmap("n", "gL"  , diagnostic .. ".setloclist({open=false})<cr>" .. telescope .. ".loclist()<cr>")
	bufmap("n", "gQ"  , diagnostic .. ".setqflist({open=false})<cr>" .. telescope .. ".quickfix()<cr>")
end


M.plugins = function()
	local opts = { noremap = true, silent = true }
	local dap = ":lua require('dap')"
	local dapui = ":lua require('dapui')"
	local keymap = function(mode, key, map) vim.keymap.set(mode, key, map, opts) end

	keymap("n", "gG" , ":Gitsigns<cr>")

	keymap("n", "<leader>tt" , ":lua _TERM_TOGGLE()<cr>")
	keymap("n", "<leader>tg" , ":lua _LAZYGIT_TOGGLE()<cr>")
	keymap("n", "<leader>tp" , ":lua _IPYTHON_TOGGLE()<cr>")
	keymap("n", "<leader>th" , ":lua _HTOP_TOGGLE()<cr>")
	keymap("n", "<leader>tsl", ":ToggleTermSendCurrentLine 3<cr>")
	keymap("v", "<leader>tsL", ":ToggleTermSendVisualLines 3<cr>")
	keymap("v", "<leader>tsv", ":ToggleTermSendVisualSelection 3<cr>")

	keymap("n", "<leader>d"  , dapui .. ".toggle()<cr>")
	keymap("n", "<leader>b"  , telescope .. ".buffers()<cr>")
	keymap("n", "<leader>g"  , telescope .. ".git_files()<cr>")
	keymap("n", "<leader>ff" , telescope .. ".find_files()<cr>")
	keymap("n", "<leader>fg" , telescope .. ".live_grep()<cr>")
	keymap("n", "<leader>fh" , telescope .. ".help_tags()<cr>")
	keymap("n", "<leader>fb" , telescope .. ".builtin()<cr>")

	keymap("n", "<F1>"       , ":lua _COMMENT()<CR>")
	keymap("v", "<F1>"       , ":lua _VCOMMENT()<CR>")
	keymap("n", "<F2>"       , ":lua vim.lsp.buf.rename()<CR>")
	keymap("n", "<F3>"       , dap .. ".step_back()<cr>")
	keymap("n", "<F4>"       , dap .. ".step_into()<cr>")
	keymap("n", "<F5>"       , dap .. ".step_over()<cr>")
	keymap("n", "<F6>"       , dap .. ".step_out()<cr>")
	keymap("n", "<F7>"       , dap .. ".continue()<cr>")
	keymap("n", "<F8>"       , dap .. ".toggle_breakpoint()<cr>")
	keymap("n", "<F9>"       , ":NvimTreeToggle<cr>")
	keymap("n", "<F10>"      , ":ToggleTerm<cr>")
	keymap("n", "<F11>"      , ":Telescope undo<cr>")
	keymap("n", "<F12>"      , ":SymbolsOutline<cr>")

	keymap("i", "<C-x><C-o>" , "<cmd>lua require('cmp').complete()<CR>")
end


M.buffer = {
	setup = function(bufnr)
		M.lsp(bufnr)
	end
}


M.global = {
	setup = function()
		M.plugins()
	end
}


return M
