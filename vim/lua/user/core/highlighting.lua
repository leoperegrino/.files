local visual_bg = 236 -- '#303030'
local statusline_bg = 233 -- '#121212'
local cursorlinenr_fg = 223 -- 'ffd7af'

local fns = require('user.core.functions')

fns.hi.set('noBgDiffAdd'   , 'NONE', fns.hi.get_group('DiffAdd').fg    )
fns.hi.set('noBgDiffText'  , 'NONE', fns.hi.get_group('DiffText').fg   )
fns.hi.set('noBgDiffChange', 'NONE', fns.hi.get_group('DiffChange').fg )
fns.hi.set('noBgDiffDelete', 'NONE', fns.hi.get_group('DiffDelete').fg )

fns.hi.set('statusline'  , statusline_bg)
fns.hi.set('cursorline'  , statusline_bg)
fns.hi.set('pmenu'       , statusline_bg)
fns.hi.set('tablinefill' , statusline_bg)
fns.hi.set('vertsplit'   , statusline_bg)
fns.hi.set('cursorlinenr', statusline_bg, cursorlinenr_fg, 'bold')

fns.hi.set('visual' , visual_bg, nil, 'NONE')
fns.hi.set('conceal', nil, 'NONE')
fns.hi.set('folded' , 'NONE')
fns.hi.set('linenr' , 'NONE')
fns.hi.set('normal' , 'NONE')

fns.hi.link('errormsg'    ,  'warningmsg')
fns.hi.link('normalfloat' ,  'pmenu'     )
fns.hi.link('spellbad'    ,  'error'     )
fns.hi.link('folded'      ,  'linenr'    )
fns.hi.link('colorcolumn' ,  'cursorline')
fns.hi.link('signcolumn'  ,  'linenr'    )
fns.hi.link('foldcolumn'  ,  'linenr'    )
fns.hi.link('nontext'     ,  'comment'   )
fns.hi.link('specialkey'  ,  'comment'   )
fns.hi.link('statuslinenc',  'linenr'    )
fns.hi.link('tabline'     ,  'statusline')
fns.hi.link('title'       ,  'statusline')
fns.hi.link('tablinesel'  ,  'statusline')
