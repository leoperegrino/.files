local comment_status_ok, comment = pcall(require, "Comment")
if not comment_status_ok then
	return
end

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
	require("Comment.api").toggle_current_linewise()
end

function _VCOMMENT()
	require("Comment.api").toggle_linewise_op(vim.fn.visualmode())
end
