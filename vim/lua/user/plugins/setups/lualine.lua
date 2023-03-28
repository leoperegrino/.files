local fns = require('user.core.functions')

local lualine = require("lualine")

local statusline  = fns.hi.get_group('StatusLine').bg
local diff_change = fns.hi.get_group('DiffChange').fg
local diff_add    = fns.hi.get_group('DiffAdd').fg
local diff_delete = fns.hi.get_group('DiffDelete').fg
local diff_text   = fns.hi.get_group('DiffText').fg
local visual_hl   = fns.hi.get_group('Visual').bg

local n = 'purple'
local i = 'green'
local v = 'blue'
local r = 'red'


local bold_statusline = { gui = 'bold', bg = statusline }
local b_bg = visual_hl

local inactive = {
	a = bold_statusline,
	b = bold_statusline,
	c = bold_statusline,
}

local normal = fns.copy(inactive)
local insert = fns.copy(inactive)
local visual = fns.copy(inactive)
local replace = fns.copy(inactive)

normal.a  = { gui = 'bold', bg = n }
insert.a  = { gui = 'bold', bg = i }
visual.a  = { gui = 'bold', bg = v }
replace.a = { gui = 'bold', bg = r }

normal.b  = { gui = 'bold', fg = n, bg = b_bg }
insert.b  = { gui = 'bold', fg = i, bg = b_bg }
visual.b  = { gui = 'bold', fg = v, bg = b_bg }
replace.b = { gui = 'bold', fg = r, bg = b_bg }

normal.c  = { gui = 'bold', fg = n, bg = statusline }
insert.c  = { gui = 'bold', fg = i, bg = statusline }
visual.c  = { gui = 'bold', fg = v, bg = statusline }
replace.c = { gui = 'bold', fg = r, bg = statusline }

local theme = {
	normal = normal,
	insert = insert,
	visual = visual,
	replace = replace,
	inactive = inactive
}

local diff_color = {
	added    = { gui = 'bold', bg = b_bg, fg = diff_add },
	modified = { gui = 'bold', bg = b_bg, fg = diff_change },
	removed  = { gui = 'bold', bg = b_bg, fg = diff_delete },
}

local diagnostics_color = {
	error = { gui = 'bold', bg = b_bg, fg = diff_delete },
	warn  = { gui = 'bold', bg = b_bg, fg = diff_text },
	info  = { gui = 'bold', bg = b_bg, fg = diff_change },
	hint  = { gui = 'bold', bg = b_bg, fg = diff_add },
}

-- local lsp_progress = {
-- 	'lsp_progress',
-- 	separators = {
-- 		component = ' ',
-- 		progress = ' | ',
-- 		percentage = { pre = '', post = '%% ' },
-- 		title = { pre = '', post = ': ' },
-- 		lsp_client_name = { pre = '[', post = ']' },
-- 		spinner = { pre = '', post = '' },
-- 		message = { commenced = 'In Progress', completed = 'Completed' },
-- 	},
-- 	display_components = { 'lsp_client_name', 'spinner', { 'title', 'percentage', 'message' } },
-- 	timer = { progress_enddelay = 500, spinner = 1000, lsp_client_name_enddelay = 1000 },
-- 	spinner_symbols = { '🌑 ', '🌒 ', '🌓 ', '🌔 ', '🌕 ', '🌖 ', '🌗 ', '🌘 ' },
-- 	fmt = function(str)
-- 		if string.len(str) > 60  then
-- 			return str:sub(1,60) .. ' ...'
-- 		else
-- 			return str
-- 		end
-- 	end,
-- }

lualine.setup {
	options = {
		icons_enabled = true,
		theme = theme,
		section_separators = { left = '', right = ' ' },
		component_separators = { left = '', right = ' ' },
		disabled_filetypes = {},
		always_divide_middle = true,
	},
	sections = {
		lualine_a = {'mode'},
		lualine_b = {
			{'branch'},
			{'diff', diff_color = diff_color},
			{'diagnostics', diagnostics_color = diagnostics_color}
	},
		lualine_c = {'filename'},
		lualine_x = {'encoding', 'fileformat'},
		lualine_y = {'location', 'progress'},
		lualine_z = {{'filetype', colored = false}}
	},
	inactive_sections = {
		lualine_a = {},
		lualine_b = {},
		lualine_c = {'filename'},
		lualine_x = {'location'},
		lualine_y = {},
		lualine_z = {}
	},
	tabline = {
		lualine_a = {'buffers'},
		lualine_b = {''},
		lualine_c = {''},
		lualine_x = {},
		lualine_y = {},
		lualine_z = {'tabs'}
	},
	extensions = {}
}
