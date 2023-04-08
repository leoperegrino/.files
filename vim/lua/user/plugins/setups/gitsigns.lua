local gitsigns = require("gitsigns")

local git_hl = function(hl_group, text)
	return {
	hl = hl_group,
	text = text,
	numhl =  hl_group,
	linehl =  hl_group,
	show_count = true
	}
end

local signs = {
	add          = git_hl('noBgDiffAdd'   , '┃'),
	change       = git_hl('noBgDiffChange', '┃'),
	delete       = git_hl('noBgDiffDelete', '▁'),
	topdelete    = git_hl('noBgDiffDelete', '▔'),
	changedelete = git_hl('noBgDiffDelete', '~')
}

gitsigns.setup {
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
	current_line_blame = false,
	current_line_blame_opts = {
		virt_text = true,
		virt_text_pos = "right_align", -- 'eol' | 'overlay' | 'right_align'
		delay = 1000,
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
	yadm = {
		enable = false,
	},
}
