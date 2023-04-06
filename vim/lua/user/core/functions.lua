local M = {}
local nvim_get_hl = vim.api.nvim_get_hl_by_name
-- local set_hl = vim.api.nvim_set_hl

M.hi = {}

M.hi.get_group = function(group, rgb)
	local ok, hl = pcall(nvim_get_hl, group, rgb)
	if not ok then
		return {}
	end

	local bg = hl.background
    local fg = hl.foreground
	if rgb then
		bg = bg and string.format("#%06x", bg) or nil
		fg = fg and string.format("#%06x", fg) or nil
	end

	return { fg = fg, bg = bg }
end


M.hi.set = function(group, bg, fg, opt)

	bg =  bg  and ' guibg='  .. bg .. ' ctermbg=' .. bg  or ''
	fg =  fg  and ' guifg='  .. fg .. ' ctermfg=' .. fg  or ''
	opt = opt and ' gui='    .. opt.. ' cterm='   .. opt or ''
	local cmd = 'highlight ' .. group .. bg .. fg .. opt

	pcall(function() vim.cmd(cmd) end)
end


M.hi.link = function(from, to)
	vim.cmd('highlight! link ' .. from .. ' ' .. to)
end


M.copy = function(original)
	local shallow = {}
	for key, value in pairs(original) do
		shallow[key] = value
	end
	return shallow
end



return M
