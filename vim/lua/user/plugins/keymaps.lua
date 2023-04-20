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

	keymap({"n", "v"}, "gG" , ":Gitsigns<cr>")
	keymap("n", "]g" , ":Gitsigns next_hunk<cr>")
	keymap("n", "[g" , ":Gitsigns prev_hunk<cr>")

	keymap("n", "Tt" , ":lua _TERM_TOGGLE()<cr>")
	keymap("n", "Tg" , ":lua _LAZYGIT_TOGGLE()<cr>")
	keymap("n", "Tp" , ":lua _IPYTHON_TOGGLE()<cr>")
	keymap("n", "Th" , ":lua _HTOP_TOGGLE()<cr>")
	keymap("n", "Tsl", ":ToggleTermSendCurrentLine 3<cr>")
	keymap("v", "TsL", ":ToggleTermSendVisualLines 3<cr>")
	keymap("v", "Tsv", ":ToggleTermSendVisualSelection 3<cr>")

	keymap("n", "<leader>d"  , dapui .. ".toggle()<cr>")
	keymap("n", "<leader>b"  , telescope .. ".buffers()<cr>")
	keymap("n", "<leader>g"  , telescope .. ".git_files()<cr>")
	keymap("n", "<leader>ff" , telescope .. ".find_files()<cr>")
	keymap("n", "<leader>fg" , telescope .. ".live_grep()<cr>")
	keymap("n", "<leader>fh" , telescope .. ".help_tags()<cr>")
	keymap("n", "tb"         , telescope .. ".buffers()<cr>")
	keymap("n", "tg"         , telescope .. ".git_files()<cr>")
	keymap("n", "tf"         , telescope .. ".find_files()<cr>")
	keymap("n", "tg"         , telescope .. ".live_grep()<cr>")
	keymap("n", "tH"         , telescope .. ".help_tags()<cr>")
	keymap("n", "th"         , telescope .. ".highlights()<cr>")
	keymap("n", "tt"         , telescope .. ".builtin()<cr>")
	keymap("n", "ts"         , telescope .. ".treesitter()<cr>")
	keymap("n", "tc"         , telescope .. ".commands()<cr>")
	keymap("n", "tk"         , telescope .. ".keymaps()<cr>")

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
