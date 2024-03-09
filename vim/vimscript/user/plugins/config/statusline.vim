execute 'hi RevStatusLine'
	   \ 'ctermfg=' . synIDattr(hlID('StatusLine'), 'bg')
	   \ 'ctermbg=' . synIDattr(hlID('StatusLine'), 'fg')
	   \ 'cterm=bold'

set statusline=%#revstatusline#
set statusline+=\ \ \ 
set statusline+=%{coc#status()}
set statusline+=\ 
set statusline+=%{get(b:,'coc_current_function','')}
set statusline+=\ 
set statusline+=
set statusline+=\ 
set statusline+=%f
set statusline+=\ 
set statusline+=%#statusline#
set statusline+=
set statusline+=\ 
set statusline+=%m
set statusline+=%r
set statusline+=%h
set statusline+=%w
set statusline+=[%l/%L,%p%%]
set statusline+=[%c]
set statusline+=%=
set statusline+=
set statusline+=\ 
set statusline+=%#revstatusline#
set statusline+=\ 
set statusline+=syn
set statusline+=[%{&syntax}]
set statusline+=
set statusline+=\ 
set statusline+=\ 
set statusline+=ft
set statusline+=[%{&filetype}]
set statusline+=\ 
