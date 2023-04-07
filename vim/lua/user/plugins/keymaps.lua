local M = {}

local opts = { noremap = true, silent = true }
local keymap = vim.keymap.set
local telescope = ":lua require('telescope.builtin')"
local dap = ":lua require('dap')"
local dapui = ":lua require('dapui')"


M.lsp = function(bufnr)
	local buf_opts = { buffer = bufnr, noremap = true, silent = true }

	keymap("n", "K"   , ":lua vim.lsp.buf.hover()<CR>"              , buf_opts)
	keymap("n", "gd"  , telescope .. ".lsp_definitions()<cr>"       , buf_opts)
	keymap("n", "gI"  , telescope .. ".lsp_implementations()<cr>"   , buf_opts)
	keymap("n", "gt"  , telescope .. ".lsp_type_definitions()<cr>"  , buf_opts)
	keymap("n", "gr"  , telescope .. ".lsp_references()<cr>"        , buf_opts)
end


M.plugins = function()
	keymap("n", "gG" , ":Gitsigns<cr>", opts)

	keymap("n", "<leader>tt" , ":lua _TERM_TOGGLE()<cr>"    , opts)
	keymap("n", "<leader>tg" , ":lua _LAZYGIT_TOGGLE()<cr>" , opts)
	keymap("n", "<leader>tp" , ":lua _IPYTHON_TOGGLE()<cr>" , opts)
	keymap("n", "<leader>th" , ":lua _HTOP_TOGGLE()<cr>"    , opts)
	keymap("n", "<leader>tsl", ":ToggleTermSendCurrentLine 3<cr>"    , opts)
	keymap("v", "<leader>tsL", ":ToggleTermSendVisualLines 3<cr>"    , opts)
	keymap("v", "<leader>tsv", ":ToggleTermSendVisualSelection 3<cr>", opts)

	keymap("n", "<leader>d"  , dapui .. ".toggle()<cr>"          , opts)
	keymap("n", "<leader>b"  , telescope .. ".buffers()<cr>"     , opts)
	keymap("n", "<leader>g"  , telescope .. ".git_files()<cr>"   , opts)
	keymap("n", "<leader>ff" , telescope .. ".find_files()<cr>"  , opts)
	keymap("n", "<leader>fg" , telescope .. ".live_grep()<cr>"   , opts)
	keymap("n", "<leader>fh" , telescope .. ".help_tags()<cr>"   , opts)
	keymap("n", "<leader>fb" , telescope .. ".builtin()<cr>"     , opts)

	keymap("n", "<F1>"       , ":lua _COMMENT()<CR>"           , opts)
	keymap("v", "<F1>"       , ":lua _VCOMMENT()<CR>"          , opts)
	keymap("n", "<F2>"       , ":lua vim.lsp.buf.rename()<CR>" , opts)
	keymap("n", "<F3>"       , dap .. ".step_back()<cr>"       , opts)
	keymap("n", "<F4>"       , dap .. ".step_into()<cr>"       , opts)
	keymap("n", "<F5>"       , dap .. ".step_over()<cr>"       , opts)
	keymap("n", "<F6>"       , dap .. ".step_out()<cr>"        , opts)
	keymap("n", "<F7>"       , dap .. ".continue()<cr>"        , opts)
	keymap("n", "<F8>"       , dap .. ".toggle_breakpoint()<cr>"  , opts)
	keymap("n", "<F9>"       , ":NvimTreeToggle<cr>"           , opts)
	keymap("n", "<F10>"      , ":ToggleTerm<cr>"               , opts)
	keymap("n", "<F11>"      , ":Telescope undo<cr>"           , opts)
	keymap("n", "<F12>"      , ":SymbolsOutline<cr>"           , opts)

	keymap("i", "<C-x><C-o>" , "<cmd>lua require('cmp').complete()<CR>", opts)
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
