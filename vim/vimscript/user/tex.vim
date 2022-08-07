let g:livepreview_previewer = 'zathura'
let g:livepreview_cursorhold_recompile = 0

" let g:vimtex_mappings_enabled = 0
let g:vimtex_compiler_method = 'arara'
let g:vimtex_view_method = 'zathura'
let g:vimtex_doc_handlers = ['MyHandler']
let g:vimtex_toc_config = {'split_width': 60, 'show_help': 0, 'split_pos': 'vert rightbelow', 'indent_levels': 1}
autocmd InsertEnter,InsertLeave *.tex let &l:textwidth = vimtex#syntax#in_mathzone() ? 0 : 80
autocmd BufRead *.tex set conceallevel=0
autocmd BufRead *.tex set fdm=manual
set wildignore+=*.acn,*.acr,*.alg,*.aux,*.bbl,*.bcf,*.blg,*.glg,*.glo,*.gls,*.ilg
set wildignore+=*.ist,*.lof,*.lot,*.nav,*.nlo,*.nls,*.out,*.run.xml,*.snm,*.tdo,*.toc,*.vrb
autocmd BufRead arara.log set foldmethod=marker
autocmd BufRead arara.log set foldmarker=----------------------\ BEGIN\ OUTPUT\ BUFFER\ ----------------------,\ END\ OUTPUT\ BUFFER\ 
function! MyHandler(context)
	call vimtex#doc#make_selection(a:context)
	if !empty(a:context.selected)
		silent! execute '!vimtexdoc' a:context.selected '&'
		redraw!
	endif
	return 1
endfunction

let g:pandoc#keyboard#use_default_mappings = 0
let g:pandoc#biblio#bibs = ['~/documents/tex/master.bib']
let g:pandoc#modules#disabled = ["hypertext", "formatting", "folding", "metadata", "keyboard", "spell"]
let g:pandoc#folding#fold_yaml = 1
