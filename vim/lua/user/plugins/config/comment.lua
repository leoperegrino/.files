local comment = require("Comment")

comment.setup {
	padding = true,
	sticky = true,
	ignore = nil,
	toggler = {
		line = 'gcc',
		block = 'gbc',
	},
	opleader = {
		line = 'gc',
		block = 'gb',
	},
	extra = {
		above = 'gcO',
		below = 'gco',
		eol = 'gcA',
	},
	mappings = {
		basic = true,
		extra = true,
		extended = false,
	},
	pre_hook = nil,
	post_hook = nil,
}

function _COMMENT()
	require("Comment.api").toggle.linewise()
end

function _VCOMMENT()
	require("Comment.api").toggle.linewise(vim.fn.visualmode())
end
