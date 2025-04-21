local gitsigns = require("gitsigns")

local sign = function(text)
	return { text = text, show_count = true }
end

local signs = {
	add          = sign('┃'),
	change       = sign('┃'),
	delete       = sign('▁'),
	topdelete    = sign('▔'),
	changedelete = sign('~'),
	untracked    = sign('┆'),
}

local function on_attach(buffer)
	local gs = gitsigns

	local function bufmap(mode, lhs, rhs, desc)
		vim.keymap.set(mode, lhs, rhs, {
			buffer = buffer,
			desc = desc,
			noremap = true,
			silent = true,
		})
	end

	local function gs_blame_line_full() gs.blame_line({ full=true }) end
	local function gs_prev_hunk() gs.prev_hunk() vim.cmd('normal zz') end
	local function gs_next_hunk() gs.next_hunk() vim.cmd('normal zz') end

	bufmap("n", "gG" , "<cmd>Gitsigns<cr>"   , "gitsigns"                     )
	bufmap("n", "g1" , gs_prev_hunk          , "gitsigns: previous hunk"      )
	bufmap("n", "g2" , gs_next_hunk          , "gitsigns: next hunk"          )
	bufmap("n", "gs" , gs.stage_hunk         , "gitsigns: stage hunk"         )
	bufmap("n", "gS" , gs.reset_hunk         , "gitsigns: reset hunk"         )
	bufmap("n", "gp" , gs.preview_hunk_inline, "gitsigns: preview hunk inline")
	bufmap("n", "gP" , gs.preview_hunk       , "gitsigns: preview hunk"       )
	bufmap("n", "gu" , gs.undo_stage_hunk    , "gitsigns: undo stage hunk"    )
	bufmap("n", "gb" , gs.blame              , "gitsigns: blame lines"        )
	bufmap("n", "gB" , gs_blame_line_full    , "gitsigns: blame line full"    )
	bufmap("n", "gz" , gs.diffthis           , "gitsigns: diff this"          )
	bufmap("n", "gZ" , gs.toggle_deleted     , "gitsigns: toggle deleted"     )
	bufmap("n", "gw" , gs.toggle_word_diff   , "gitsigns: toggle word diff"   )
end


gitsigns.setup({
	signs = signs,
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
})
