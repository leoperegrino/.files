local M = {}

local utils = require('user.utils')
local get_hl = utils.get_hl
local update_hl = utils.update_hl
local link_hl = utils.link_hl

local visual_bg = 236 -- '#303030'
local statusline_bg = 233 -- '#121212'
local cursorlinenr_fg = 223 -- 'ffd7af'


local set_no_bg_hl = function(name, val)
	val.ctermbg = nil
	val.cterm.reverse = false
	val.cterm.bold = true

	return update_hl(name, val)
end


M.setup = function()
	set_no_bg_hl('noBgDiffAdd'   , get_hl('DiffAdd'   ))
	set_no_bg_hl('noBgDiffText'  , get_hl('DiffText'  ))
	set_no_bg_hl('noBgDiffChange', get_hl('DiffChange'))
	set_no_bg_hl('noBgDiffDelete', get_hl('DiffDelete'))

	set_no_bg_hl('title', get_hl('statusline'))

	update_hl('statusline'  , { ctermbg = statusline_bg })
	update_hl('cursorline'  , { ctermbg = statusline_bg, ctermfg = 'none', cterm = {} })
	update_hl('pmenu'       , { ctermbg = statusline_bg })
	update_hl('tablinefill' , { ctermbg = statusline_bg })
	update_hl('vertsplit'   , { ctermbg = statusline_bg })
	update_hl('cursorlinenr', { ctermbg = statusline_bg, ctermfg = cursorlinenr_fg, cterm = { bold = true } })

	update_hl('visual' , { ctermbg = visual_bg , cterm = {} })
	update_hl('conceal', { ctermfg = 'none' })
	update_hl('linenr' , { ctermbg = 'none' })
	update_hl('normal' , { ctermbg = 'none' })

	link_hl('errormsg'    ,  'warningmsg')
	link_hl('normalfloat' ,  'pmenu'     )
	link_hl('spellbad'    ,  'error'     )
	link_hl('folded'      ,  'linenr'    )
	link_hl('colorcolumn' ,  'cursorline')
	link_hl('signcolumn'  ,  'linenr'    )
	link_hl('foldcolumn'  ,  'linenr'    )
	link_hl('nontext'     ,  'comment'   )
	link_hl('specialkey'  ,  'comment'   )
	link_hl('statuslinenc',  'linenr'    )
	link_hl('tabline'     ,  'statusline')
	link_hl('tablinesel'  ,  'statusline')
end


return M
