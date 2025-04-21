local M = {}

local keymap_with = require('user.utils').keymap_with


M.setup = function()
	local telescope = require('telescope.builtin')
	local api = require('nvim-tree.api')

	local keymap = keymap_with({
		noremap = true,
		silent = true
	})

	keymap("n", "<leader>b" , telescope.buffers        , "telescope: buffers"     )
	keymap("n", "<leader>g" , function() telescope.git_files({ cwd = require('telescope.utils').buffer_dir() }) end, "telescope: git files"  )
	keymap("n", "<leader>f" , function() telescope.find_files({ cwd = require('telescope.utils').buffer_dir() }) end, "telescope: find files"  )
	keymap("n", "<leader>F" , telescope.find_files     , "telescope: find files"  )
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

	keymap("n", "<F10>"      , function() api.tree.toggle({ path = vim.fn.expand('%:p:h') }) end, "nvim-tree: open in cwd" )
	keymap("n", "<F11>"      , "<cmd>Outline<cr>")
	keymap("n", "<F12>"      , "<cmd>ZenMode<cr>")

	keymap("i", "<C-x><C-o>" , "<cmd>lua require('cmp').complete()<CR>")
end


return M
