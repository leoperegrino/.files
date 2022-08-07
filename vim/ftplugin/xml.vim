setlocal foldlevel=1
" set equalprg=xmllint\ --format\ --recover\ -\ 2>/dev/null

command! -nargs=0 XMLint normal mm:%!XMLLINT_INDENT='	' xmllint --format --recover -<CR>`m
