local function on_attach(buffer)
	local gs = require("gitsigns")

	local function bufmap(mode, lhs, rhs, desc)
		vim.keymap.set(mode, lhs, rhs, {
			buffer = buffer,
			desc = 'gitsigns: ' .. desc,
			noremap = true,
			silent = true,
		})
	end

	local function gs_blame_line_full() gs.blame_line( { full = true } ) end
	local function callback() vim.cmd.normal('zz') end
	local function gs_prev_hunk() gs.nav_hunk('prev', nil, callback) end
	local function gs_next_hunk() gs.nav_hunk('next', nil, callback) end

	bufmap("n", "gG" , "<cmd>Gitsigns<cr>"   , ""                   )
	bufmap("n", "g1" , gs_prev_hunk          , "previous hunk"      )
	bufmap("n", "g2" , gs_next_hunk          , "next hunk"          )
	bufmap("n", "gs" , gs.stage_hunk         , "stage hunk"         )
	bufmap("n", "gS" , gs.reset_hunk         , "reset hunk"         )
	bufmap("n", "gp" , gs.preview_hunk_inline, "preview hunk inline")
	bufmap("n", "gP" , gs.preview_hunk       , "preview hunk"       )
	bufmap("n", "gu" , gs.undo_stage_hunk    , "undo stage hunk"    )
	bufmap("n", "gb" , gs.blame              , "blame lines"        )
	bufmap("n", "gB" , gs_blame_line_full    , "blame line full"    )
	bufmap("n", "gz" , gs.diffthis           , "diff this"          )
	bufmap("n", "gZ" , gs.toggle_deleted     , "toggle deleted"     )
	bufmap("n", "gw" , gs.toggle_word_diff   , "toggle word diff"   )
end


return {
	{ 'lewis6991/gitsigns.nvim',
		opts = {
			signs = {
				add          = { text = '┃', show_count = true },
				change       = { text = '┃', show_count = true },
				delete       = { text = '▁', show_count = true },
				topdelete    = { text = '▔', show_count = true },
				changedelete = { text = '~', show_count = true },
				untracked    = { text = '┆', show_count = true },
			},
			on_attach = on_attach,
			signcolumn = true,
			numhl = true,
			linehl = false,
			word_diff = false,
			watch_gitdir = {
				interval = 1000,
				follow_files = true,
			},
			attach_to_untracked = true,
			current_line_blame = true,
			current_line_blame_opts = {
				virt_text = false,
				virt_text_pos = "right_align", -- 'eol' | 'overlay' | 'right_align'
				delay = 300,
				ignore_whitespace = false,
			},
			current_line_blame_formatter = '<author>, <author_time:%Y-%m-%d> - <summary>',
			sign_priority = 6,
			update_debounce = 100,
			status_formatter = nil,
			max_file_length = 40000,
			preview_config = {
				border = "single",
				style = "minimal",
				relative = "cursor",
				row = 0,
				col = 1,
			},
			count_chars = {
				[1]   = '₁',
				[2]   = '₂',
				[3]   = '₃',
				[4]   = '₄',
				[5]   = '₅',
				[6]   = '₆',
				[7]   = '₇',
				[8]   = '₈',
				[9]   = '₉',
				['+'] = '+',
			},
		},
	},
}
