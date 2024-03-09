function! g:Untrail() abort
	execute '%s/\s\+$//g'
endfunction

function! g:XMLint() abort
	normal mm:%!XMLLINT_INDENT='	' xmllint --format --recover -<CR>`m
endfunction
