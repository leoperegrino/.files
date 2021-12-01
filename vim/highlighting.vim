syntax on

execute 'hi CocGitChangedSign       ctermfg=' . synIDattr(hlID('DiffChange'), 'fg')
execute 'hi CocGitAddedSign         ctermfg=' . synIDattr(hlID('DiffAdd'), 'fg')
execute 'hi CocGitRemovedSign       ctermfg=' . synIDattr(hlID('DiffDelete'), 'fg')
execute 'hi CocGitTopRemovedSign    ctermfg=' . synIDattr(hlID('DiffDelete'), 'fg')
execute 'hi CocGitChangeRemovedSign ctermfg=' . synIDattr(hlID('DiffChange'), 'fg')

hi       MidTab       ctermfg=0 ctermbg=none
hi       conceal      ctermbg=NONE
hi       cursorline   ctermbg=233 term=NONE
hi       cursorlinenr ctermbg=233 ctermfg=223
hi       folded       ctermbg=NONE
hi       linenr       ctermbg=NONE
hi       normal       ctermbg=NONE
hi       pmenu        ctermbg=234
hi       tablinefill  ctermbg=233
hi       title        ctermbg=NONE ctermfg=10 cterm=bold
hi       statusline   ctermbg=233
hi       statuslinenc ctermbg=233
hi       vertsplit    ctermbg=233
hi       visual       ctermbg=236 cterm=NONE
hi! link spellbad     error
hi! link folded       linenr
hi! link signcolumn   linenr
hi! link foldcolumn   linenr
hi! link colorcolumn  cursorline
hi! link nontext      comment
hi! link specialkey   comment
hi! link tabline      statuslinenc
hi! link tablinesel   statusline

call matchadd('MidTab', '\S\+\zs\t\+', -1)
