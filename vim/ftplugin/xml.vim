setlocal foldlevel=1
" set equalprg=xmllint\ --format\ --recover\ -\ 2>/dev/null

nnoremap <F4> mm:%!XMLLINT_INDENT='	' xmllint --format --recover -<CR>`m
