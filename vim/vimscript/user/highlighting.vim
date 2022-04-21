let s:statusline_bg = 233

execute 'hi statusline   ctermbg=' . s:statusline_bg
execute 'hi cursorline   ctermbg=' . s:statusline_bg
execute 'hi pmenu        ctermbg=' . s:statusline_bg
execute 'hi tablinefill  ctermbg=' . s:statusline_bg
execute 'hi vertsplit    ctermbg=' . s:statusline_bg
execute 'hi cursorlinenr ctermbg=' . s:statusline_bg . 'ctermfg=223'

hi       visual       ctermbg=236 cterm=NONE
hi       conceal      ctermbg=NONE
hi       folded       ctermbg=NONE
hi       linenr       ctermbg=NONE
hi       normal       ctermbg=NONE
hi! link errormsg     warningmsg
hi! link normalfloat  pmenu
hi! link spellbad     error
hi! link folded       linenr
hi! link colorcolumn  cursorline
hi! link signcolumn   linenr
hi! link foldcolumn   linenr
hi! link nontext      comment
hi! link specialkey   comment
hi! link statuslinenc linenr
hi! link tabline      statusline
hi! link title        statusline
hi! link tablinesel   statusline
