local M = {}

local keymap_with = require('user.utils').keymap_with


local vsplit = function()
	local actions = require('telescope.actions')
	actions.select_default:replace(actions.select_vertical)
	return true
end


M.on_attach = function(_, bufnr)
	local telescope = require('telescope.builtin')

	local bufmap = keymap_with({
		buffer = bufnr,
		noremap = true,
	})

	bufmap("n", "gd"  , telescope.lsp_definitions     )
	bufmap("n", "gI"  , telescope.lsp_implementations )
	bufmap("n", "gt"  , telescope.lsp_type_definitions)
	bufmap("n", "gr"  , telescope.lsp_references      )
	bufmap("n", "gD"  , function() telescope.lsp_definitions({ attach_mappings = vsplit })          end)
	bufmap("n", "gR"  , function() telescope.lsp_references({ jump_type = 'vsplit' })               end)
	bufmap("n", "gL"  , function() vim.diagnostic.setloclist({ open = false }) telescope.loclist()  end)
	bufmap("n", "gQ"  , function() vim.diagnostic.setqflist({ open = false })  telescope.quickfix() end)
end


M.setup = function()
	local telescope = require('telescope.builtin')
	local gitsigns = require('gitsigns')

	local keymap = keymap_with({
		noremap = true,
		silent = true
	})


	keymap({"n", "v"}, "gG" , "<cmd>Gitsigns<cr>"   )
	keymap("n", "g1" , gitsigns.prev_hunk)
	keymap("n", "g2" , gitsigns.next_hunk)
	keymap("n", "gs" , gitsigns.stage_hunk)
	keymap("v", "gs" , function() gitsigns.stage_hunk({ vim.fn.line('.'), vim.fn.line('v') }) end)
	keymap("n", "gS" , gitsigns.reset_hunk)
	keymap("v", "gS" , function() gitsigns.reset_hunk({ vim.fn.line('.'), vim.fn.line('v') }) end)
	keymap("n", "gp" , gitsigns.preview_hunk_inline)
	keymap("n", "gP" , gitsigns.preview_hunk)
	keymap("n", "gu" , gitsigns.undo_stage_hunk)
	keymap("n", "gb" , function() gitsigns.blame_line({ full=true }) end)
	keymap("n", "gB" , gitsigns.blame_line)
	keymap("n", "gz" , gitsigns.diffthis)
	keymap("n", "gZ" , gitsigns.toggle_deleted)

	keymap("n", "<leader>b"  , telescope.buffers   )
	keymap("n", "<leader>g"  , telescope.git_files )
	keymap("n", "<leader>f"  , telescope.find_files)
	keymap("n", "<leader>G"  , telescope.live_grep )
	keymap("n", "<leader>t"  , telescope.help_tags )
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
	keymap("n", "tr"         , telescope.oldfiles  )
	keymap("n", "tu"         , "<cmd>Telescope undo<cr>")

	keymap("n", "<F1>"       , ':lua require("Comment.api").toggle.linewise()<CR>')
	keymap("v", "<F1>"       , ':lua require("Comment.api").toggle.linewise(vim.fn.visualmode())<CR>')
	keymap("n", "<F2>"       , vim.lsp.buf.rename   )

	keymap("n", "<F9>"       , "<cmd>NvimTreeToggle<cr>")
	keymap("n", "<F12>"      , "<cmd>ZenMode<cr>")

	keymap("i", "<C-x><C-o>" , "<cmd>lua require('cmp').complete()<CR>")
end


return M
