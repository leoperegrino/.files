local M = {}

local keymap_with = require('user.utils').keymap_with


M.setup = function()
	local telescope = require('telescope.builtin')
	local api = require('nvim-tree.api')

	local keymap = keymap_with({
		noremap = true,
		silent = true
	})

	keymap("n", "<F1>"       , ':lua require("Comment.api").toggle.linewise()<CR>')
	keymap("v", "<F1>"       , ':lua require("Comment.api").toggle.linewise(vim.fn.visualmode())<CR>')
	keymap("n", "<F2>"       , vim.lsp.buf.rename   )

	keymap("n", "<F10>"      , function() api.tree.toggle({ path = vim.fn.expand('%:p:h') }) end, "nvim-tree: open in cwd" )
	keymap("n", "<F11>"      , "<cmd>Outline<cr>")
	keymap("n", "<F12>"      , "<cmd>ZenMode<cr>")

	keymap("i", "<C-x><C-o>" , "<cmd>lua require('cmp').complete()<CR>")
end


return M
