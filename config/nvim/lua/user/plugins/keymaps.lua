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

	bufmap("n", "gd"  , telescope.lsp_definitions     , "telescope lsp: lsp definitions")
	bufmap("n", "gI"  , telescope.lsp_implementations , "telescope lsp: lsp implementations")
	bufmap("n", "gt"  , telescope.lsp_type_definitions, "telescope lsp: lsp type definitions")
	bufmap("n", "gr"  , telescope.lsp_references      , "telescope lsp: lsp references")
	bufmap("n", "gD"  , function() telescope.lsp_definitions({ attach_mappings = vsplit })          end, "telescope lsp: lsp definitions")
	bufmap("n", "gR"  , function() telescope.lsp_references({ attach_mappings = vsplit })           end, "telescope lsp: lsp references")
	bufmap("n", "gL"  , function() vim.diagnostic.setloclist({ open = false }) telescope.loclist()  end, "telescope lsp: location list")
	bufmap("n", "gQ"  , function() vim.diagnostic.setqflist({ open = false })  telescope.quickfix() end, "telescope lsp: quickfix list")
end


M.setup = function()
	local telescope = require('telescope.builtin')
	local gs = require('gitsigns')

	local keymap = keymap_with({
		noremap = true,
		silent = true
	})

	local visual = { vim.fn.line('.'), vim.fn.line('v') }
	local gs_v_stage_hunk = function() gs.stage_hunk(visual) end
	local gs_v_reset_hunk = function() gs.reset_hunk(visual) end
	local gs_blame_line_full = function() gs.blame_line({ full=true }) end

	keymap("n", "gG" , "<cmd>Gitsigns<cr>"   , "gitsigns"                     )
	keymap("n", "g1" , gs.prev_hunk          , "gitsigns: previous hunk"      )
	keymap("n", "g2" , gs.next_hunk          , "gitsigns: next hunk"          )
	keymap("n", "gs" , gs.stage_hunk         , "gitsigns: stage hunk"         )
	keymap("v", "gs" , gs_v_stage_hunk       , "gitsigns: visual stage hunk"  )
	keymap("n", "gS" , gs.reset_hunk         , "gitsigns: reset hunk"         )
	keymap("v", "gS" , gs_v_reset_hunk       , "gitsigns: visual reset hunk"  )
	keymap("n", "gp" , gs.preview_hunk_inline, "gitsigns: preview hunk inline")
	keymap("n", "gP" , gs.preview_hunk       , "gitsigns: preview hunk"       )
	keymap("n", "gu" , gs.undo_stage_hunk    , "gitsigns: undo stage hunk"    )
	keymap("n", "gb" , gs_blame_line_full    , "gitsigns: blame line full"    )
	keymap("n", "gB" , gs.blame_line         , "gitsigns: blame line"         )
	keymap("n", "gz" , gs.diffthis           , "gitsigns: diff this"          )
	keymap("n", "gZ" , gs.toggle_deleted     , "gitsigns: toggle deleted"     )

	keymap("n", "<leader>b" , telescope.buffers        , "telescope: buffers"     )
	keymap("n", "<leader>g" , telescope.git_files      , "telescope: git files"   )
	keymap("n", "<leader>f" , telescope.find_files     , "telescope: find files"  )
	keymap("n", "<leader>G" , telescope.live_grep      , "telescope: live grep"   )
	keymap("n", "<leader>t" , telescope.help_tags      , "telescope: help tags"   )
	keymap("n", "tb"        , telescope.buffers        , "telescope: buffers"     )
	keymap("n", "tg"        , telescope.git_files      , "telescope: git files"   )
	keymap("n", "tf"        , telescope.find_files     , "telescope: find files"  )
	keymap("n", "tg"        , telescope.live_grep      , "telescope: live grep"   )
	keymap("n", "tH"        , telescope.help_tags      , "telescope: help tags"   )
	keymap("n", "th"        , telescope.git_commits    , "telescope: git commits" )
	keymap("n", "tj"        , telescope.git_bcommits   , "telescope: git buffer commits" )
	keymap("n", "tt"        , telescope.builtin        , "telescope: builtins"    )
	keymap("n", "ts"        , telescope.git_status     , "telescope: git status"  )
	keymap("n", "tS"        , telescope.spell_suggest  , "telescope: spell suggest")
	keymap("n", "tc"        , telescope.commands       , "telescope: commands"    )
	keymap("n", "tk"        , telescope.keymaps        , "telescope: keymaps"     )
	keymap("n", "tr"        , telescope.oldfiles       , "telescope: recent files")
	keymap("n", "tu"        , "<cmd>Telescope undo<cr>", "telescope: undo"        )

	keymap('n', 'glk'       , function() telescope.keymaps({ default_text = 'lsp: ' }) end, "lsp: keymaps")

	keymap("n", "<F1>"       , ':lua require("Comment.api").toggle.linewise()<CR>')
	keymap("v", "<F1>"       , ':lua require("Comment.api").toggle.linewise(vim.fn.visualmode())<CR>')
	keymap("n", "<F2>"       , vim.lsp.buf.rename   )

	keymap("n", "<F10>"      , "<cmd>NvimTreeToggle<cr>")
	keymap("n", "<F12>"      , "<cmd>ZenMode<cr>")

	keymap("i", "<C-x><C-o>" , "<cmd>lua require('cmp').complete()<CR>")
end


return M
