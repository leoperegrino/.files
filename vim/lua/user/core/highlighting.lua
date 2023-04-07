local M = {}

local utils = require('user.utils')

local visual_bg = 236 -- '#303030'
local statusline_bg = 233 -- '#121212'
local cursorlinenr_fg = 223 -- 'ffd7af'


M.setup = function()
	utils.hi.set('noBgDiffAdd'   , 'NONE', utils.hi.get_group('DiffAdd').fg    )
	utils.hi.set('noBgDiffText'  , 'NONE', utils.hi.get_group('DiffText').fg   )
	utils.hi.set('noBgDiffChange', 'NONE', utils.hi.get_group('DiffChange').fg )
	utils.hi.set('noBgDiffDelete', 'NONE', utils.hi.get_group('DiffDelete').fg )

	utils.hi.set('statusline'  , statusline_bg)
	utils.hi.set('cursorline'  , statusline_bg, 'none', 'none')
	utils.hi.set('pmenu'       , statusline_bg)
	utils.hi.set('tablinefill' , statusline_bg)
	utils.hi.set('vertsplit'   , statusline_bg)
	utils.hi.set('cursorlinenr', statusline_bg, cursorlinenr_fg, 'bold')

	utils.hi.set('visual' , visual_bg, nil, 'NONE')
	utils.hi.set('conceal', nil, 'NONE')
	utils.hi.set('folded' , 'NONE')
	utils.hi.set('linenr' , 'NONE')
	utils.hi.set('normal' , 'NONE')

	utils.hi.link('errormsg'    ,  'warningmsg')
	utils.hi.link('normalfloat' ,  'pmenu'     )
	utils.hi.link('spellbad'    ,  'error'     )
	utils.hi.link('folded'      ,  'linenr'    )
	utils.hi.link('colorcolumn' ,  'cursorline')
	utils.hi.link('signcolumn'  ,  'linenr'    )
	utils.hi.link('foldcolumn'  ,  'linenr'    )
	utils.hi.link('nontext'     ,  'comment'   )
	utils.hi.link('specialkey'  ,  'comment'   )
	utils.hi.link('statuslinenc',  'linenr'    )
	utils.hi.link('tabline'     ,  'statusline')
	utils.hi.link('title'       ,  'statusline')
	utils.hi.link('tablinesel'  ,  'statusline')
end


return M
