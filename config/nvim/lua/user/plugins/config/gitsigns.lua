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

gitsigns.setup({
	signs = signs,
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
