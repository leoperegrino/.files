local M = {}

local telescope = require('telescope.builtin')

local keymap_with = require('user.utils').keymap_with


local vsplit = function()
	local actions = require('telescope.actions')
	actions.select_default:replace(actions.select_vertical)
	return true
end


M.on_attach = function(_, bufnr)
	local bufmap = keymap_with({
		buffer = bufnr,
		noremap = true,
	})

	bufmap("n", "gd"  , telescope.lsp_definitions     )
	bufmap("n", "gI"  , telescope.lsp_implementations )
	bufmap("n", "gt"  , telescope.lsp_type_definitions)
	bufmap("n", "gr"  , telescope.lsp_references      )
	bufmap("n", "gR"  , function() telescope.lsp_references({ attach_mappings = vsplit })         end)
	bufmap("n", "gL"  , function() vim.diagnostic.setloclist({ open=false }) telescope.loclist()  end)
	bufmap("n", "gQ"  , function() vim.diagnostic.setqflist({ open=false })  telescope.quickfix() end)
end


M.setup = function()
	local keymap = keymap_with({
		noremap = true,
		silent = true
	})


	keymap({"n", "v"}, "gG" , "<cmd>Gitsigns<cr>"   )
	keymap("n", "]g" , "<cmd>Gitsigns next_hunk<cr>")
	keymap("n", "[g" , "<cmd>Gitsigns prev_hunk<cr>")

	keymap("n", "<leader>b"  , telescope.buffers   )
	keymap("n", "<leader>g"  , telescope.git_files )
	keymap("n", "<leader>ff" , telescope.find_files)
	keymap("n", "<leader>fg" , telescope.live_grep )
	keymap("n", "<leader>fh" , telescope.help_tags )
	keymap("n", "tb"         , telescope.buffers   )
	keymap("n", "tg"         , telescope.git_files )
	keymap("n", "tf"         , telescope.find_files)
	keymap("n", "tg"         , telescope.live_grep )
	keymap("n", "tH"         , telescope.help_tags )
	keymap("n", "th"         , telescope.highlights)
	keymap("n", "tt"         , telescope.builtin   )
	keymap("n", "ts"         , telescope.treesitter)
	keymap("n", "tc"         , telescope.commands  )
	keymap("n", "tk"         , telescope.keymaps   )

	keymap("n", "<F1>"       , ':lua require("Comment.api").toggle.linewise()<CR>')
	keymap("v", "<F1>"       , ':lua require("Comment.api").toggle.linewise(vim.fn.visualmode())<CR>')
	keymap("n", "<F2>"       , vim.lsp.buf.rename   )

	keymap("n", "<F9>"       , "<cmd>NvimTreeToggle<cr>")
	keymap("n", "<F10>"      , "<cmd>ToggleTerm<cr>"    )
	keymap("n", "<F11>"      , "<cmd>Telescope undo<cr>")
	keymap("n", "<F12>"      , "<cmd>SymbolsOutline<cr>")

	keymap("i", "<C-x><C-o>" , "<cmd>lua require('cmp').complete()<CR>")
end


return M
